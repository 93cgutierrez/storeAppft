import 'package:storeapp/app/core/domain/entity/user_entity.dart';

abstract class UserDataSource {
  Future<List<UserEntity>> getUsers();
}
