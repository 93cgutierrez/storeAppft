import 'package:dio/dio.dart';
import 'package:storeapp/app/core/data/remote/dto/user_data_model.dart';
import 'package:storeapp/app/util/log.util.dart';
import 'package:storeapp/app/util/parameters.dart';

final class UserService {
  static const String _tag = 'ProductService';
  final Dio apiClient;
  final String baseUrl = Parameters.baseUrl;

  UserService({
    required this.apiClient,
  });

  //createUser
  Future<bool> create(UserDataModel user) async {
    try {
      final Response response = await apiClient.post(
        '$baseUrl/users.json',
        data: user.toJson(),
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ),
      );
      if (response.statusCode == 200) {
        Log.i(_tag, 'Usuario creado exitosamente');
        return true;
      } else {
        Log.e(_tag,
            'Error al crear el usuario: ${response.statusCode} - ${response.data.toString()}');
        throw Exception();
      }
    } catch (e) {
      Log.e(_tag, e.toString());
      throw Exception('Error al crear el usuario $e');
    }
  }
}
