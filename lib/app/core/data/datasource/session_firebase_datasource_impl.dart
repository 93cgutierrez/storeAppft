import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:storeapp/app/core/domain/datasource/session_datasource.dart';
import 'package:storeapp/app/util/log.util.dart';

class SessionFirebaseDatasourceImpl implements SessionDatasource {
  static const String _tag = 'SessionFirebaseDatasourceImpl';
  final SharedPreferences prefs;
  final FirebaseAuth firebaseAuth;

  SessionFirebaseDatasourceImpl({
    required this.prefs,
    required this.firebaseAuth,
  });

  @override
  Future<bool> logout() async {
    try {
      firebaseAuth.signOut();
      return await prefs.clear();
    } on FirebaseAuthException catch (e) {
      Log.e(_tag, "Error logging out: $e");
      rethrow;
    } catch (e) {
      Log.e(_tag, "Error logging out: $e");
      rethrow;
    }
  }
}
