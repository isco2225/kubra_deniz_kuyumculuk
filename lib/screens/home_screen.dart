import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

import '../core/app_colors.dart';
import '../core/shop_contact.dart';
import '../models/product.model.dart';
import '../repositories/product_repository.dart';
import '../widgets/brand_logo.dart';
import '../widgets/product_card.dart';
import '../widgets/product_image.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key, required this.repository});

  final ProductRepository repository;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<ProductModel>>(
        future: repository.getProducts(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          final products = snapshot.data!;
          final bestSellers = products.where((item) => item.isBestSeller).toList();
          final categories = <String, String>{};
          for (final product in products) {
            categories.putIfAbsent(product.category, () => product.images.first);
          }

          return CustomScrollView(
            slivers: [
              const SliverToBoxAdapter(child: _SiteHeader()),
              SliverToBoxAdapter(child: _HeroSection(onExplore: () {})),
              SliverToBoxAdapter(
                child: _SectionTitle(
                  title: 'Goz Kamastiranlar',
                  subtitle: 'Koleksiyonumuzun en cok ilgi goren secimleri',
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                sliver: SliverGrid(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final product = bestSellers[index];
                      return ProductCard(
                        product: product,
                        onInspect: () => context.go('/product/${product.id}'),
                      );
                    },
                    childCount: bestSellers.length,
                  ),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: _bestSellerColumns(MediaQuery.sizeOf(context).width),
                    crossAxisSpacing: 18,
                    mainAxisSpacing: 18,
                    childAspectRatio: 0.72,
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: _SectionTitle(
                  title: 'Koleksiyonlar',
                  subtitle: 'Her zevke hitap eden seckin kategoriler',
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(20, 8, 20, 40),
                sliver: SliverGrid(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final category = categories.entries.elementAt(index);
                      return _CategoryCard(
                        name: category.key,
                        imageUrl: category.value,
                      );
                    },
                    childCount: categories.length,
                  ),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: MediaQuery.sizeOf(context).width >= 980 ? 3 : 2,
                    crossAxisSpacing: 18,
                    mainAxisSpacing: 18,
                    childAspectRatio: 1.3,
                  ),
                ),
              ),
              const SliverToBoxAdapter(
                child: _SectionTitle(
                  title: 'Iletisim',
                  subtitle: 'Siparis ve bilgi almak icin bize ulasin',
                ),
              ),
              const SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(20, 8, 20, 40),
                  child: _ContactSection(),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  int _bestSellerColumns(double width) {
    if (width >= 1300) return 5;
    if (width >= 900) return 4;
    if (width >= 640) return 3;
    return 2;
  }
}

class _SiteHeader extends StatelessWidget {
  const _SiteHeader();

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.sizeOf(context).width < 780;
    return Container(
      color: AppColors.matteBlack,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      child: Row(
        children: [
          const BrandLogo(size: 46),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              'Kubra Deniz KUYUMCULUK',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: AppColors.gold,
                    letterSpacing: 0.7,
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ),
          if (!isMobile)
            Wrap(
              spacing: 26,
              children: const [
                _MenuItem(label: 'Ana Sayfa'),
                _MenuItem(label: 'Koleksiyonlar'),
                _MenuItem(label: 'Iletisim'),
              ],
            ),
        ],
      ),
    );
  }
}

class _MenuItem extends StatelessWidget {
  const _MenuItem({required this.label});
  final String label;

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: Theme.of(context).textTheme.titleMedium?.copyWith(
            color: AppColors.ivory,
            fontWeight: FontWeight.w500,
          ),
    );
  }
}

class _HeroSection extends StatelessWidget {
  const _HeroSection({required this.onExplore});
  final VoidCallback onExplore;

  @override
  Widget build(BuildContext context) {
    final isNarrow = MediaQuery.sizeOf(context).width < 900;
    return Container(
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.gold.withValues(alpha: 0.38)),
      ),
      child: Flex(
        direction: isNarrow ? Axis.vertical : Axis.horizontal,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 10,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Isiltinizi Kesfedin',
                  style: Theme.of(context).textTheme.displayMedium,
                ),
                const SizedBox(height: 14),
                Text(
                  'Kubra Deniz Kuyumculuk seckisiyle zamansiz parcalari kesfedin. '
                  'Her urun, ince isciligi ve premium detaylari ile hazirlandi.',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: onExplore,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.gold,
                    foregroundColor: AppColors.matteBlack,
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                  ),
                  child: const Text('Koleksiyonu Kesfet'),
                ),
              ],
            ),
          ),
          const SizedBox(width: 22, height: 22),
          Expanded(
            flex: 9,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: AspectRatio(
                aspectRatio: 1.2,
                child: const ProductImage(
                  source: 'assets/zincirler/gurmet_zincir_kolye_1.jpg',
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle({required this.title, required this.subtitle});

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 18, 20, 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: Theme.of(context).textTheme.headlineMedium),
          const SizedBox(height: 4),
          Text(subtitle, style: Theme.of(context).textTheme.bodyMedium),
        ],
      ),
    );
  }
}

class _CategoryCard extends StatelessWidget {
  const _CategoryCard({required this.name, required this.imageUrl});

  final String name;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(18),
      child: Stack(
        fit: StackFit.expand,
        children: [
          ProductImage(source: imageUrl, fit: BoxFit.cover),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withValues(alpha: 0.14),
                  Colors.black.withValues(alpha: 0.58),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: const EdgeInsets.all(14),
              child: Text(
                name,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: AppColors.ivory,
                    ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ContactSection extends StatelessWidget {
  const _ContactSection();

  Future<void> _launchPhone() async {
    await launchUrl(ShopContact.phoneUri);
  }

  Future<void> _launchWhatsApp() async {
    final uri = Uri.parse(
      ShopContact.whatsAppUrl(
        message: 'Merhaba, ürünler hakkında bilgi almak istiyorum.',
      ),
    );
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }

  Future<void> _launchMaps() async {
    final uri = Uri.parse(ShopContact.mapsUrl);
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }

  Future<void> _launchInstagram() async {
    final uri = Uri.parse(ShopContact.instagramUrl);
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }

  @override
  Widget build(BuildContext context) {
    final isNarrow = MediaQuery.sizeOf(context).width < 860;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.gold.withValues(alpha: 0.35)),
      ),
      child: Flex(
        direction: isNarrow ? Axis.vertical : Axis.horizontal,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  ShopContact.shopName,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: 10),
                Text(
                  'Yeni koleksiyonlar, sipariş süreci ve ürün detayları için bizi arayabilir '
                  'veya WhatsApp üzerinden hızlıca yazabilirsiniz.',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox(height: 18),
                Text(
                  'Telefon: ${ShopContact.phoneDisplay}',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 6),
                Text(
                  'Adres: ${ShopContact.address}',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: 6),
                Text(
                  'Çalışma saatleri: ${ShopContact.workingHours}',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: 6),
                Text(
                  'Instagram: @kubradenizkuyumculuk',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ),
          const SizedBox(width: 20, height: 20),
          SizedBox(
            width: isNarrow ? double.infinity : 280,
            child: Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: _launchPhone,
                    icon: const Icon(Icons.call_outlined),
                    label: const Text('Hemen Ara'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.gold,
                      foregroundColor: AppColors.matteBlack,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: _launchWhatsApp,
                    icon: const Icon(Icons.chat_bubble_outline),
                    label: const Text('WhatsApp ile Yaz'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF25D366),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      elevation: 2,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: _launchMaps,
                    icon: const Icon(Icons.location_on_outlined),
                    label: const Text('Konumu Aç'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.charcoal,
                      foregroundColor: AppColors.gold,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      elevation: 2,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: _launchInstagram,
                    icon: const Icon(Icons.camera_alt_outlined),
                    label: const Text('Instagram'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFC13584),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      elevation: 2,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
