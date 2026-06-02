import 'package:flutter/material.dart';

import '../../../core/app_colors.dart';
import '../../../models/product.model.dart';
import '../../../widgets/product_image.dart';

class ProductGalleryPane extends StatelessWidget {
  const ProductGalleryPane({
    super.key,
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
                    child: ProductImage(
                      source: product.images[index],
                      fit: BoxFit.cover,
                    ),
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
