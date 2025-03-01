import 'package:storeapp/app/core/domain/entity/product_entity.dart';

abstract class HomeRepository {
  //getProducts
  Future<List<ProductEntity>> getProducts();

  //deleteProduct
  Future<bool> deleteProduct({required String productId});
}
