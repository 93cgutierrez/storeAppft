import 'package:storeapp/app/core/domain/entity/user_entity.dart';

class UserDataModel {
  final String id;
  late final String name;
  late final String document;
  late final String email;
  late final String password;
  late final String imageProfileUrl;

  UserDataModel({
    required this.id,
    required this.name,
    required this.document,
    required this.email,
    required this.password,
    required this.imageProfileUrl,
  });

  //fromJson
  UserDataModel.fromJson(this.id, Map<String, dynamic> json) {
    name = json['name'];
    document = json['document'];
    email = json['email'];
    password = json['password'];
    imageProfileUrl = json['image'];
  }

  //toEntity
  UserEntity toEntity() {
    return UserEntity(
      id: id,
      name: name,
      document: document,
      email: email,
      password: password,
      imageProfileUrl: imageProfileUrl,
    );
  }

  //toJson
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'document': document,
      'email': email,
      //'password': password,
      'imageProfileUrl': imageProfileUrl,
    };
  }
}
