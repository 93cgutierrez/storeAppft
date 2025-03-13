import 'package:storeapp/app/core/domain/entity/user_entity.dart';

abstract class SignUpDatasource {
  Future<bool> createUser(UserEntity entity);
}
