import 'package:dio/dio.dart';
import 'package:storeapp/app/core/data/remote/dto/product_data_model.dart';
import 'package:storeapp/app/util/log.util.dart';

final class ProductService {
  static const String _tag = 'ProductService';
  final Dio apiClient;
  final String baseUrl = 'https://storeappdamo2024-default-rtdb.firebaseio.com';

  ProductService({
    required this.apiClient,
  });

  //getAllProducts
  Future<List<ProductDataModel>> getAllProducts() async {
    List<ProductDataModel> products = [];
    try {
      final Response response = await apiClient.get('$baseUrl/products.json');
      if (response.statusCode == 200 && response.data != null) {
        response.data.forEach((key, value) {
          products.add(ProductDataModel.fromJson(key, value));
        });
        return products;
      } else {
        Log.e(_tag, 'Error al obtener los productos');
        //throw Exception('Error al obtener los productos');
        return products;
      }
    } catch (e) {
      Log.e(_tag, e.toString());
      throw Exception('Error al obtener los productos $e');
    }
  }

  //deleteProduct
  Future<void> deleteProduct(String productId) async {
    try {
      final Response response =
          await apiClient.delete('$baseUrl/products/$productId.json');
      if (response.statusCode == 200) {
        Log.i(_tag, 'Producto eliminado exitosamente');
      } else {
        Log.e(_tag, 'Error al eliminar el producto');
        throw Exception('Error al eliminar el producto');
      }
    } catch (e) {
      Log.e(_tag, e.toString());
      throw Exception('Error al eliminar el producto $e');
    }
  }
}
