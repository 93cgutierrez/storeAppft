import 'package:dio/dio.dart';
import 'package:storeapp/app/core/data/remote/dto/product_data_model.dart';
import 'package:storeapp/app/util/log.util.dart';

final class ProductService {
  static const String _tag = 'ProductService';
  final Dio apiClient;
  final String baseUrl =
      'https://especializacion-mobile-default-rtdb.firebaseio.com';

  ProductService({
    required this.apiClient,
  });

  //getAllProducts
  Future<List<ProductDataModel>> getAll() async {
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
  Future<bool> delete(String productId) async {
    try {
      final Response response =
          await apiClient.delete('$baseUrl/products/$productId.json');
      if (response.statusCode == 200) {
        Log.i(_tag, 'Producto eliminado exitosamente');
        return true;
      } else {
        Log.e(_tag, 'Error al eliminar el producto');
        throw Exception();
      }
    } catch (e) {
      Log.e(_tag, e.toString());
      throw Exception('Error al eliminar el producto $e');
    }
  }

  //addProduct
  Future<bool> add(ProductDataModel product) async {
    try {
      final Response response = await apiClient.post(
        '$baseUrl/products.json',
        data: product.toJson(),
      );
      if (response.statusCode == 200) {
        Log.i(_tag, 'Producto agregado exitosamente');
        return true;
      } else {
        Log.e(_tag, 'Error al agregar el producto');
        throw Exception();
      }
    } catch (e) {
      Log.e(_tag, e.toString());
      throw Exception('Error al agregar el producto $e');
    }
  }

  //getProduct
  Future<ProductDataModel> get(String productId) async {
    try {
      final Response response =
          await apiClient.get('$baseUrl/products/$productId.json');
      if (response.statusCode == 200 && response.data != null) {
        return ProductDataModel.fromJson(productId, response.data);
      } else {
        Log.e(_tag, 'Error al obtener el producto');
        throw Exception();
      }
    } catch (e) {
      Log.e(_tag, e.toString());
      throw Exception('Error al obtener el producto $e');
    }
  }

  //updateProduct
  Future<bool> update(ProductDataModel product) async {
    try {
      final Response response = await apiClient.patch(
        '$baseUrl/products/${product.id}.json',
        data: product.toJson(),
      );
      if (response.statusCode == 200) {
        Log.i(_tag, 'Producto actualizado exitosamente');
        return true;
      } else {
        Log.e(_tag, 'Error al actualizar el producto');
        throw Exception();
      }
    } catch (e) {
      Log.e(_tag, e.toString());
      throw Exception('Error al actualizar el producto $e');
    }
  }
}
