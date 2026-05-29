import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

import '../core/app_colors.dart';
import '../core/shop_contact.dart';
import '../models/product.model.dart';
import '../repositories/product_repository.dart';
import '../widgets/brand_logo.dart';
import '../widgets/product_image.dart';

class ProductDetailScreen extends StatefulWidget {
  const ProductDetailScreen({
    super.key,
    required this.repository,
    required this.productId,
  });

  final ProductRepository repository;
  final String productId;

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  int selectedImageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<ProductModel?>(
        future: widget.repository.getProductById(widget.productId),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            if (snapshot.connectionState == ConnectionState.done) {
              return const Center(child: Text('Urun bulunamadi.'));
            }
            return const Center(child: CircularProgressIndicator());
          }
          final product = snapshot.data!;
          final isNarrow = MediaQuery.sizeOf(context).width < 980;

          return CustomScrollView(
            slivers: [
              const SliverToBoxAdapter(child: _DetailHeader()),
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(20, 24, 20, 40),
                sliver: SliverToBoxAdapter(
                  child: Flex(
                    direction: isNarrow ? Axis.vertical : Axis.horizontal,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 11,
                        child: _GalleryPane(
                          product: product,
                          selectedImageIndex: selectedImageIndex,
                          onImageSelected: (index) =>
                              setState(() => selectedImageIndex = index),
                        ),
                      ),
                      const SizedBox(width: 24, height: 24),
                      Expanded(
                        flex: 9,
                        child: _DetailPane(product: product),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _DetailHeader extends StatelessWidget {
  const _DetailHeader();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.matteBlack,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      child: Row(
        children: [
          InkWell(
            onTap: () => context.go('/'),
            child: const Row(
              children: [
                BrandLogo(size: 40),
                SizedBox(width: 10),
                Text(
                  'Kubra Deniz KUYUMCULUK',
                  style: TextStyle(
                    color: AppColors.gold,
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          ),
          const Spacer(),
          TextButton.icon(
            onPressed: () => context.go('/'),
            icon: const Icon(Icons.arrow_back, color: AppColors.ivory),
            label: const Text(
              'Geri',
              style: TextStyle(color: AppColors.ivory),
            ),
          ),
        ],
      ),
    );
  }
}

class _GalleryPane extends StatelessWidget {
  const _GalleryPane({
    required this.product,
    required this.selectedImageIndex,
    required this.onImageSelected,
  });

  final ProductModel product;
  final int selectedImageIndex;
  final ValueChanged<int> onImageSelected;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: AspectRatio(
            aspectRatio: 1.05,
            child: ProductImage(
              source: product.images[selectedImageIndex],
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 92,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              final selected = index == selectedImageIndex;
              return GestureDetector(
                onTap: () => onImageSelected(index),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 180),
                  width: 92,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: selected ? AppColors.gold : Colors.transparent,
                      width: 2,
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: ProductImage(source: product.images[index], fit: BoxFit.cover),
                  ),
                ),
              );
            },
            separatorBuilder: (context, index) => const SizedBox(width: 10),
            itemCount: product.images.length,
          ),
        ),
      ],
    );
  }
}

class _DetailPane extends StatelessWidget {
  const _DetailPane({required this.product});

  final ProductModel product;

  Future<void> _launchWhatsApp() async {
    final message =
        'Merhaba, ${product.name} (Kod: ${product.id}) hakkında bilgi almak istiyorum.';
    final url = Uri.parse(ShopContact.whatsAppUrl(message: message));
    await launchUrl(url, mode: LaunchMode.externalApplication);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.gold.withValues(alpha: 0.4)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(product.name, style: Theme.of(context).textTheme.displaySmall),
          const SizedBox(height: 10),
          Text(product.description, style: Theme.of(context).textTheme.bodyLarge),
          const SizedBox(height: 20),
          Text(
            'Urun Ozellikleri',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 8),
          ...product.specs.entries.map(
            (entry) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: Row(
                children: [
                  SizedBox(
                    width: 90,
                    child: Text(
                      entry.key,
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),
                  Text(': ${entry.value}'),
                ],
              ),
            ),
          ),
          const SizedBox(height: 28),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: _launchWhatsApp,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF25D366),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                textStyle: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                ),
              ),
              icon: const Icon(Icons.chat_bubble_outline),
              label: const Text('WhatsApp ile Bilgi Al'),
            ),
          ),
        ],
      ),
    );
  }
}
