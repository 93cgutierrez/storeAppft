import 'package:shared_preferences/shared_preferences.dart';
import 'package:storeapp/app/core/domain/datasource/session_datasource.dart';
import 'package:storeapp/app/util/log.util.dart';
import 'package:storeapp/app/util/parameters.dart';

class SessionLocalDatasourceImpl implements SessionDatasource {
  static const String _tag = 'SessionLocalDatasourceImpl';
  final SharedPreferences prefs;

  SessionLocalDatasourceImpl({required this.prefs});

  @override
  Future<bool> logout() async {
    try {
      return await prefs.remove(Parameters.isLoggedKey);
    } catch (e) {
      Log.e(_tag, 'Error al cerrar sesión $e');
      return false;
    }
  }
}
