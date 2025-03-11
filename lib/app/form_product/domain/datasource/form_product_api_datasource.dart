import 'package:storeapp/app/core/domain/entity/product_entity.dart';

abstract class FormProductDatasource {
  Future<bool> addProduct(ProductEntity productEntity);

  Future<ProductEntity> getProduct(String id);

  Future<bool> updateProduct(ProductEntity productEntity);
}
