import 'dart:math';

import 'package:storeapp/app/login/domain/entity/login_entity.dart';
import 'package:storeapp/app/login/domain/respository/login_repository.dart';

class LoginRepositoryImpl implements LoginRepository {
  @override
  bool login(LoginEntity entity) {
    return Random().nextBool();
  }
}
