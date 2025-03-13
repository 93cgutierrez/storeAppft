import 'package:storeapp/app/core/domain/entity/user_entity.dart';

abstract class SignupRepository {
  Future<bool> createUser(UserEntity entity);
}
