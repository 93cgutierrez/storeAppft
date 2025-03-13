import 'package:storeapp/app/core/domain/entity/user_entity.dart';

abstract class SignUpRepository {
  Future<bool> createUser(UserEntity entity);
}
