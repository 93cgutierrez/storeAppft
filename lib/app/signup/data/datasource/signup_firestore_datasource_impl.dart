import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:storeapp/app/core/domain/entity/user_entity.dart';
import 'package:storeapp/app/signup/domain/datasource/signup_datasource.dart';
import 'package:storeapp/app/util/log.util.dart';
import 'package:storeapp/app/util/parameters.dart';

class SignupFirestoreDatasourceImpl implements SignupDatasource {
  static const String _tag = 'SignupFirebaseDatasource';
  final FirebaseFirestore firebaseFirestore;
  final FirebaseAuth firebaseAuth;
  final String usersName = Parameters.usersName;

  SignupFirestoreDatasourceImpl({
    required this.firebaseFirestore,
    required this.firebaseAuth,
  });

  @override
  Future<bool> createUser(UserEntity entity) async {
    try {
      if (entity.password == null) {
        throw Exception("Password is null");
      }
      UserCredential userCredential =
          await firebaseAuth.createUserWithEmailAndPassword(
        email: entity.email,
        password: entity.password ?? '',
      );
      final String savedId = userCredential.user?.uid ?? '';
      Log.d(_tag, "created account id: $savedId");
      await firebaseFirestore.collection(usersName).doc(savedId).set(
            entity.copyWith(id: savedId).toMap(),
          );
      return true;
    } on FirebaseAuthException catch (e) {
      Log.e(_tag, "Error creating user: $e");
      if (e.message.toString().contains(
          'The email address is already in use by another account.')) {
        throw Exception('El correo electrónico ya está en uso');
      }
      rethrow;
    }
  }
}
