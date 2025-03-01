import 'package:storeapp/app/core/data/remote/dto/product_data_model.dart';
import 'package:storeapp/app/core/data/remote/service/product_service.dart';
import 'package:storeapp/app/core/domain/entity/product_entity.dart';
import 'package:storeapp/app/home/domain/repository/home_repository.dart';
import 'package:storeapp/app/util/log.util.dart';

class HomeRepositoryImpl implements HomeRepository {
  static const String _tag = 'HomeRepositoryImpl';
  final ProductService productService;

  HomeRepositoryImpl({required this.productService});

  @override
  Future<bool> deleteProduct({required String productId}) async {
    try {
      await productService.deleteProduct(productId);
      return true;
    } catch (e) {
      Log.e(_tag, e.toString());
      throw Exception('Error al eliminar el producto $e');
    }
  }

  @override
  Future<List<ProductEntity>> getProducts() async {
    final List<ProductEntity> products = [];
    try {
      final List<ProductDataModel> response =
          await productService.getAllProducts();
      for (var product in response) {
        products.add(
          ProductEntity(
            id: product.id,
            name: product.name,
            image: product.imageUrl,
            price: product.price,
          ),
        );
      }
      return products;
    } catch (e) {
      Log.e(_tag, e.toString());
      throw Exception('Error al obtener los productos $e');
    }
  }
}
