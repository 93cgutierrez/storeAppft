import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:storeapp/app/login/domain/datasource/login_datasource.dart';
import 'package:storeapp/app/login/domain/entity/login_entity.dart';
import 'package:storeapp/app/util/log.util.dart';
import 'package:storeapp/app/util/parameters.dart';

class LoginFirebaseDatasourceImpl implements LoginDatasource {
  static const String _tag = 'LoginFirebaseDatasource';
  final SharedPreferences prefs;
  final FirebaseAuth firebaseAuth;

  LoginFirebaseDatasourceImpl({
    required this.prefs,
    required this.firebaseAuth,
  });

  @override
  Future<bool> login(LoginEntity entity) async {
    try {
      UserCredential userCredential =
          await firebaseAuth.signInWithEmailAndPassword(
        email: entity.email,
        password: entity.password,
      );
      final String savedId = userCredential.user?.uid ?? '';
      Log.d(_tag, "logged in account id: $savedId");
      await prefs.setBool(
        Parameters.isLoggedKey,
        savedId.isNotEmpty,
      );
      await prefs.setString(
        Parameters.userKey,
        savedId.isNotEmpty ? savedId : '',
      );
      return savedId.isNotEmpty;
    } on FirebaseAuthException catch (e) {
      Log.e(_tag, "Error logging in: $e");
      if (e.message != null && e.message!.contains('credential is incorrect')) {
        return false;
      }
      rethrow;
    } catch (e) {
      Log.e(_tag, "Error logging in: $e");
      rethrow;
    }
  }
}
