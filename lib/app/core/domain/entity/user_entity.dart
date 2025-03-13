import 'package:storeapp/app/core/data/remote/dto/user_data_model.dart';

class UserEntity {
  final String id;
  final String name;
  final String document;
  final String email;
  final String password;
  final String imageProfileUrl;

  UserEntity({
    required this.id,
    required this.name,
    required this.document,
    required this.email,
    required this.password,
    required this.imageProfileUrl,
  });

  //toUserDataModel
  UserDataModel toUserDataModel() {
    return UserDataModel(
      id: id,
      name: name,
      document: document,
      email: email,
      password: password,
      imageProfileUrl: imageProfileUrl,
    );
  }

  //copyWith
  UserEntity copyWith({
    String? id,
    String? name,
    String? document,
    String? email,
    String? password,
    String? imageProfileUrl,
  }) {
    return UserEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      document: document ?? this.document,
      email: email ?? this.email,
      password: password ?? this.password,
      imageProfileUrl: imageProfileUrl ?? this.imageProfileUrl,
    );
  }
}
