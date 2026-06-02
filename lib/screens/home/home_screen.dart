import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../models/product.model.dart';
import '../../repositories/product_repository.dart';
import '../../widgets/product_card.dart';
import 'widgets/category_card.dart';
import 'widgets/contact_section.dart';
import 'widgets/hero_section.dart';
import 'widgets/section_title.dart';
import 'widgets/site_header.dart';

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
          final bestSellers = products
              .where((item) => item.isBestSeller)
              .toList();
          final categories = <String, String>{};
          for (final product in products) {
            categories.putIfAbsent(
              product.category,
              () => product.images.first,
            );
          }

          return CustomScrollView(
            slivers: [
              const SliverToBoxAdapter(child: SiteHeader()),
              SliverToBoxAdapter(child: HeroSection(onExplore: () {})),
              const SliverToBoxAdapter(
                child: HomeSectionTitle(
                  title: 'Göz Kamaştıranlar',
                  subtitle: 'Koleksiyonumuzun en çok ilgi gören seçimleri',
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 8,
                ),
                sliver: SliverGrid(
                  delegate: SliverChildBuilderDelegate((context, index) {
                    final product = bestSellers[index];
                    return ProductCard(
                      product: product,
                      onInspect: () => context.go('/product/${product.id}'),
                    );
                  }, childCount: bestSellers.length),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: bestSellerColumns(
                      MediaQuery.sizeOf(context).width,
                    ),
                    crossAxisSpacing: 18,
                    mainAxisSpacing: 18,
                    childAspectRatio: 0.72,
                  ),
                ),
              ),
              const SliverToBoxAdapter(
                child: HomeSectionTitle(
                  title: 'Koleksiyonlar',
                  subtitle: 'Her zevke hitap eden seçkin kategoriler',
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(20, 8, 20, 40),
                sliver: SliverGrid(
                  delegate: SliverChildBuilderDelegate((context, index) {
                    final category = categories.entries.elementAt(index);
                    return HomeCategoryCard(
                      name: category.key,
                      imageUrl: category.value,
                    );
                  }, childCount: categories.length),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: MediaQuery.sizeOf(context).width >= 980
                        ? 3
                        : 2,
                    crossAxisSpacing: 18,
                    mainAxisSpacing: 18,
                    childAspectRatio: 1.3,
                  ),
                ),
              ),
              const SliverToBoxAdapter(
                child: HomeSectionTitle(
                  title: 'İletişim',
                  subtitle: 'Sipariş ve bilgi almak için bize ulaşın',
                ),
              ),
              const SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(20, 8, 20, 48),
                  child: ContactSection(),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

int bestSellerColumns(double width) {
  if (width >= 1300) return 5;
  if (width >= 900) return 4;
  if (width >= 640) return 3;
  return 2;
}
