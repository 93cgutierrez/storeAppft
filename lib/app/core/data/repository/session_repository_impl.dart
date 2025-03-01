import 'package:shared_preferences/shared_preferences.dart';
import 'package:storeapp/app/core/domain/repository/session_repository.dart';
import 'package:storeapp/app/util/log.util.dart';

const String _tag = 'SessionRepositoryImpl';

class SessionRepositoryImpl implements SessionRepository {
  @override
  Future<bool> logout() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      return await prefs.remove('isLogged');
    } catch (e) {
      Log.e(_tag, 'Error al cerrar sesión $e');
      return false;
    }
  }
}
