import 'package:storeapp/app/login/domain/datasource/login_datasource.dart';
import 'package:storeapp/app/login/domain/entity/login_entity.dart';
import 'package:storeapp/app/login/domain/repository/login_repository.dart';

class LoginRepositoryImpl implements LoginRepository {
  final LoginDatasource loginDatasource;

  LoginRepositoryImpl({required this.loginDatasource});

  @override
  Future<bool> login(LoginEntity entity) async {
    return await loginDatasource.login(entity);
  }
}
