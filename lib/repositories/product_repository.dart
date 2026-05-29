import '../models/product.model.dart';

abstract class ProductRepository {
  Future<List<ProductModel>> getProducts();
  Future<List<ProductModel>> getBestSellers();
  Future<ProductModel?> getProductById(String id);
  Future<Map<String, String>> getCategoryCoverImages();
}
