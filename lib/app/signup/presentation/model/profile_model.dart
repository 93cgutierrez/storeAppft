import 'package:storeapp/app/core/domain/entity/user_entity.dart';

class ProfileModel {
  String id;
  String name;
  String document;
  String email;
  String password;
  String confirmPassword;
  String imageProfileUrl;

  //empty constructor
  ProfileModel.empty()
      : id = '',
        name = '',
        document = '',
        email = '',
        password = '',
        confirmPassword = '',
        imageProfileUrl = '';

  ProfileModel({
    required this.id,
    required this.name,
    required this.document,
    required this.email,
    required this.password,
    required this.confirmPassword,
    required this.imageProfileUrl,
  });

  ProfileModel copyWith({
    String? id,
    String? name,
    String? document,
    String? email,
    String? password,
    String? confirmPassword,
    String? imageProfileUrl,
  }) {
    return ProfileModel(
      id: id ?? this.id,
      name: name ?? this.name,
      document: document ?? this.document,
      email: email ?? this.email,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      imageProfileUrl: imageProfileUrl ?? this.imageProfileUrl,
    );
  }

  //toUserEntity
  UserEntity toUserEntity() {
    return UserEntity(
      id: id,
      name: name,
      document: document,
      email: email,
      password: password,
      imageProfileUrl: imageProfileUrl,
    );
  }

  //toString
  @override
  String toString() {
    return 'ProfileModel{id: $id, name: $name, document: $document, email: $email, password: $password, confirmPassword: $confirmPassword, imageProfileUrl: $imageProfileUrl}';
  }
}
