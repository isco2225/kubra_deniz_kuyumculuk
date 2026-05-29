class ProductModel {
  const ProductModel({
    required this.id,
    required this.name,
    required this.description,
    required this.images,
    required this.category,
    required this.isBestSeller,
    required this.specs,
  });

  final String id;
  final String name;
  final String description;
  final List<String> images;
  final String category;
  final bool isBestSeller;
  final Map<String, String> specs;
}
