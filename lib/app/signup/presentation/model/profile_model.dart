import 'package:storeapp/app/core/domain/entity/user_entity.dart';

class ProfileModel {
  String id;
  String name;
  String document;
  String email;
  String password;
  String imageProfileUrl;

  //empty constructor
  ProfileModel.empty()
      : id = '',
        name = '',
        document = '',
        email = '',
        password = '',
        imageProfileUrl = '';

  ProfileModel({
    required this.id,
    required this.name,
    required this.document,
    required this.email,
    required this.password,
    required this.imageProfileUrl,
  });

  ProfileModel copyWith({
    String? id,
    String? name,
    String? document,
    String? email,
    String? password,
    String? imageProfileUrl,
  }) {
    return ProfileModel(
      id: id ?? this.id,
      name: name ?? this.name,
      document: document ?? this.document,
      email: email ?? this.email,
      password: password ?? this.password,
      imageProfileUrl: imageProfileUrl ?? this.imageProfileUrl,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'document': document,
      'email': email,
      'password': password,
      'imageProfileUrl': imageProfileUrl,
    };
  }

  factory ProfileModel.fromMap(Map<String, dynamic> map) {
    return ProfileModel(
      id: map['id'],
      name: map['name'],
      document: map['document'],
      email: map['email'],
      password: map['password'],
      imageProfileUrl: map['image'],
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
    return 'ProfileModel{id: $id, name: $name, document: $document, email: $email, imageProfileUrl: $imageProfileUrl}';
  }
}
