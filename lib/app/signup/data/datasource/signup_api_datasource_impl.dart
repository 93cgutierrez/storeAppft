import 'package:storeapp/app/core/data/remote/service/user_service.dart';
import 'package:storeapp/app/core/domain/entity/user_entity.dart';
import 'package:storeapp/app/signup/domain/datasource/signup_datasource.dart';

class SignupApiDatasourceImpl implements SignUpDatasource {
  final UserService userService;

  SignupApiDatasourceImpl({required this.userService});

  @override
  Future<bool> createUser(UserEntity entity) {
    try {
      return userService.create(entity.toUserDataModel());
    } catch (e) {
      throw (Exception());
    }
  }
}
