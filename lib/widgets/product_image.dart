import 'package:flutter/material.dart';

/// Ürün görseli; `assets/...` yollarında [Image.asset], aksi halde [Image.network] kullanır.
class ProductImage extends StatelessWidget {
  const ProductImage({
    super.key,
    required this.source,
    this.fit = BoxFit.cover,
    this.width,
    this.height,
    this.errorBuilder,
  });

  final String source;
  final BoxFit fit;
  final double? width;
  final double? height;
  final ImageErrorWidgetBuilder? errorBuilder;

  static bool isAsset(String path) => path.startsWith('assets/');

  @override
  Widget build(BuildContext context) {
    if (isAsset(source)) {
      return Image.asset(
        source,
        fit: fit,
        width: width,
        height: height,
        errorBuilder: errorBuilder ?? _defaultErrorBuilder,
      );
    }
    return Image.network(
      source,
      fit: fit,
      width: width,
      height: height,
      errorBuilder: errorBuilder ?? _defaultErrorBuilder,
    );
  }

  static Widget _defaultErrorBuilder(
    BuildContext context,
    Object error,
    StackTrace? stackTrace,
  ) {
    return Container(
      color: Colors.black12,
      alignment: Alignment.center,
      child: const Icon(Icons.image_not_supported_outlined),
    );
  }
}
