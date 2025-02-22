import 'package:storeapp/app/login/domain/entity/login_entity.dart';

abstract class LoginRepository {
  bool login(LoginEntity entity);
}
