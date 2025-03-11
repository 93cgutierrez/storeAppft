import 'package:storeapp/app/core/data/remote/service/product_service.dart';
import 'package:storeapp/app/core/domain/entity/product_entity.dart';
import 'package:storeapp/app/home/domain/datasource/home_datasource.dart';

class HomeApiDatasourceImpl implements HomeDataSource {
  final ProductService productService;

  HomeApiDatasourceImpl({required this.productService});

  @override
  Future<bool> deleteProduct(String id) {
    try {
      return productService.delete(id);
    } catch (e) {
      throw (Exception(e));
    }
  }

  @override
  Future<List<ProductEntity>> getProducts() async {
    final List<ProductEntity> products = [];
    try {
      final response = await productService.getAll();
      for (var element in response) {
        products.add(element.toEntity());
      }
    } catch (e) {
      throw (Exception(e));
    }

    return products;
  }
}
