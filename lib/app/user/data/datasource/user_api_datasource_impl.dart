import 'package:storeapp/app/core/data/remote/service/user_service.dart';
import 'package:storeapp/app/core/domain/entity/user_entity.dart';
import 'package:storeapp/app/user/domain/datasource/user_datasource.dart';

class UserApiDataSourceImp implements UserDataSource {
  final UserService userService;

  UserApiDataSourceImp({required this.userService});

  @override
  Future<List<UserEntity>> getUsers() async {
    final List<UserEntity> users = [];
    try {
      final response = await userService.getAll();
      for (var element in response) {
        users.add(element.toEntity());
      }
    } catch (e) {
      throw (Exception(e));
    }
    return users;
  }
}
