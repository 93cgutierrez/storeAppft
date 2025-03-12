import 'package:shared_preferences/shared_preferences.dart';
import 'package:storeapp/app/login/domain/datasource/login_datasource.dart';
import 'package:storeapp/app/login/domain/entity/login_entity.dart';
import 'package:storeapp/app/util/parameters.dart';

class LoginLocalDatasourceImpl implements LoginDatasource {
  final SharedPreferences prefs;

  LoginLocalDatasourceImpl({required this.prefs});

  @override
  Future<bool> login(LoginEntity entity) async {
    await prefs.setBool(Parameters.isLoggedKey, true);
    return true;
  }
}
