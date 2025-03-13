import 'package:storeapp/app/core/domain/entity/user_entity.dart';
import 'package:storeapp/app/signup/domain/datasource/signup_datasource.dart';
import 'package:storeapp/app/signup/domain/repository/signup_repository.dart';

class SignUpRepositoryImpl implements SignUpRepository {
  final SignUpDatasource signUpDatasource;

  SignUpRepositoryImpl({required this.signUpDatasource});

  @override
  Future<bool> createUser(UserEntity entity) {
    return signUpDatasource.createUser(entity);
  }
}
