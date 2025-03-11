import 'package:storeapp/app/core/data/remote/service/product_service.dart';
import 'package:storeapp/app/core/domain/entity/product_entity.dart';
import 'package:storeapp/app/form_product/domain/datasource/form_product_api_datasource.dart';

class FormProductApiDatasourceImpl implements FormProductDatasource {
  final ProductService productService;

  FormProductApiDatasourceImpl({required this.productService});

  @override
  Future<bool> addProduct(ProductEntity productEntity) {
    try {
      return productService.add(productEntity.toProductDataModel());
    } catch (e) {
      throw (Exception());
    }
  }

  @override
  Future<ProductEntity> getProduct(String id) async {
    try {
      final response = await productService.get(id);
      return response.toEntity();
    } catch (e) {
      throw (Exception());
    }
  }

  @override
  Future<bool> updateProduct(ProductEntity productEntity) {
    try {
      return productService.update(productEntity.toProductDataModel());
    } catch (e) {
      throw (Exception());
    }
  }
}
