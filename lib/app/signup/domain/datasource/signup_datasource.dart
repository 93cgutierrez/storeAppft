import 'package:storeapp/app/core/domain/entity/user_entity.dart';

abstract class SignupDatasource {
  Future<bool> createUser(UserEntity entity);
}
