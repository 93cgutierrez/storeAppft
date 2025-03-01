import 'package:storeapp/app/core/domain/entity/product_entity.dart';

abstract class HomeRepository {
  //getProducts
  List<ProductEntity> getProducts();

  //deleteProduct
  bool deleteProduct({required String productId});
}
