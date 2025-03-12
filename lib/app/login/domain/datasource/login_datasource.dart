import 'package:storeapp/app/login/domain/entity/login_entity.dart';

abstract class LoginDatasource {
  Future<bool> login(LoginEntity entity);
}
