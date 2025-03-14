import 'package:dio/dio.dart';
import 'package:storeapp/app/core/data/remote/dto/user_data_model.dart';
import 'package:storeapp/app/util/log.util.dart';
import 'package:storeapp/app/util/parameters.dart';

final class UserService {
  static const String _tag = 'UserService';
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
        Log.i(_tag, 'Usuario creado exitosamente id: ${response.data['name']}');
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

  //getAll
  Future<List<UserDataModel>> getAll() async {
    List<UserDataModel> users = [];
    try {
      final Response response = await apiClient.get('$baseUrl/users.json');
      if (response.statusCode == 200) {
        response.data.forEach((key, value) {
          users.add(UserDataModel.fromJson(key, value));
        });
        Log.d(_tag, 'Todos los usuarios obtenidos: ${users.length}');
        return users;
      } else {
        Log.e(_tag,
            'Error al obtener todos los usuarios: ${response.statusCode} - ${response.data.toString()}');
        return users;
      }
    } catch (e) {
      Log.e(_tag, e.toString());
      throw Exception('Error al obtener todos los usuarios $e');
    }
  }
}
