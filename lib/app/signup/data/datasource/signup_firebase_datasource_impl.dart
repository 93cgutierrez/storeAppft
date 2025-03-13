import 'package:firebase_auth/firebase_auth.dart';
import 'package:storeapp/app/core/data/remote/service/user_service.dart';
import 'package:storeapp/app/core/domain/entity/user_entity.dart';
import 'package:storeapp/app/signup/domain/datasource/signup_datasource.dart';
import 'package:storeapp/app/util/log.util.dart';

class SignupFirebaseDatasourceImpl implements SignupDatasource {
  static const String _tag = 'SignupFirebaseDatasource';
  final UserService userService;
  final FirebaseAuth firebaseAuth;

  SignupFirebaseDatasourceImpl({
    required this.userService,
    required this.firebaseAuth,
  });

  @override
  Future<bool> createUser(UserEntity entity) async {
    try {
      UserCredential userCredential =
          await firebaseAuth.createUserWithEmailAndPassword(
        email: entity.email,
        password: entity.password,
      );
      final String savedId = userCredential.user?.uid ?? '';
      Log.d(_tag, "created account id: $savedId");
      return userService.create(entity
          .copyWith(
            id: savedId,
          )
          .toUserDataModel());
    } catch (e) {
      Log.e(_tag, "Error creating user: $e");
      rethrow;
    }
  }
}
