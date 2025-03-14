import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:storeapp/app/core/domain/entity/user_entity.dart';
import 'package:storeapp/app/user/domain/datasource/user_datasource.dart';
import 'package:storeapp/app/util/log.util.dart';
import 'package:storeapp/app/util/parameters.dart';

class UserFirestoreDataSourceImp implements UserDataSource {
  static const String _tag = 'UserFirestoreDataSourceImp';
  final FirebaseFirestore firebaseFirestore;
  final String usersName = Parameters.usersName;

  UserFirestoreDataSourceImp({required this.firebaseFirestore});

  @override
  Future<List<UserEntity>> getUsers() async {
    final List<UserEntity> users = [];
    try {
      final QuerySnapshot<Map<String, dynamic>> response =
          await firebaseFirestore.collection(usersName).get();
      for (QueryDocumentSnapshot<Map<String, dynamic>> doc in response.docs) {
        users.add(UserEntity.fromJson(doc.id, doc.data()));
      }
    } catch (e) {
      Log.e(_tag, 'Error al obtener los usuarios $e');
      throw (Exception(e));
    }
    return users;
  }
}
