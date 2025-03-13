import 'package:storeapp/app/core/domain/entity/user_entity.dart';
import 'package:storeapp/app/signup/domain/datasource/signup_datasource.dart';
import 'package:storeapp/app/signup/domain/repository/signup_repository.dart';

class SignUpRepositoryImpl implements SignupRepository {
  final SignupDatasource signupDatasource;

  SignUpRepositoryImpl({required this.signupDatasource});

  @override
  Future<bool> createUser(UserEntity entity) {
    return signupDatasource.createUser(entity);
  }
}
