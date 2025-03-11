import 'package:storeapp/app/core/domain/entity/product_entity.dart';
import 'package:storeapp/app/form_product/domain/datasource/form_product_api_datasource.dart';
import 'package:storeapp/app/form_product/domain/repository/form_product_repository.dart';

class FormProductRepositoryImpl implements FormProductRepository {
  final FormProductDatasource formProductDatasource;

  FormProductRepositoryImpl({required this.formProductDatasource});

  @override
  Future<bool> addProduct(ProductEntity productEntity) async {
    return await formProductDatasource.addProduct(productEntity);
  }

  @override
  Future<ProductEntity> getProduct(String id) async {
    return await formProductDatasource.getProduct(id);
  }

  @override
  Future<bool> updateProduct(ProductEntity productEntity) async {
    return await formProductDatasource.updateProduct(productEntity);
  }
}
