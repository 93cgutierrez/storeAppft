import 'package:storeapp/app/core/domain/entity/user_entity.dart';
import 'package:storeapp/app/user/domain/datasource/user_datasource.dart';
import 'package:storeapp/app/user/domain/repository/user_repository.dart';

class UserRepositoryImp implements UserRepository {
  final UserDataSource userDataSource;

  UserRepositoryImp({required this.userDataSource});

  @override
  Future<List<UserEntity>> getUsers() async {
    return await userDataSource.getUsers();
  }
}
