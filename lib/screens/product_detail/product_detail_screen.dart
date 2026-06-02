import 'package:flutter/material.dart';

import '../../models/product.model.dart';
import '../../repositories/product_repository.dart';
import 'widgets/detail_header.dart';
import 'widgets/detail_pane.dart';
import 'widgets/gallery_pane.dart';

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
              return const Center(child: Text('Ürün bulunamadı.'));
            }
            return const Center(child: CircularProgressIndicator());
          }
          final product = snapshot.data!;
          final isNarrow = MediaQuery.sizeOf(context).width < 980;

          return CustomScrollView(
            slivers: [
              const SliverToBoxAdapter(child: DetailHeader()),
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(20, 24, 20, 40),
                sliver: SliverToBoxAdapter(
                  child: Flex(
                    direction: isNarrow ? Axis.vertical : Axis.horizontal,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Flexible(
                        flex: isNarrow ? 0 : 11,
                        fit: isNarrow ? FlexFit.loose : FlexFit.tight,
                        child: ProductGalleryPane(
                          product: product,
                          selectedImageIndex: selectedImageIndex,
                          onImageSelected: (index) =>
                              setState(() => selectedImageIndex = index),
                        ),
                      ),
                      const SizedBox(width: 24, height: 24),
                      Flexible(
                        flex: isNarrow ? 0 : 9,
                        fit: isNarrow ? FlexFit.loose : FlexFit.tight,
                        child: ProductDetailPane(product: product),
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
