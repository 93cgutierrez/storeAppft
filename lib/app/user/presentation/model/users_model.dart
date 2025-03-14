import 'package:storeapp/app/core/data/remote/dto/user_data_model.dart';

class UsersModel {
  final List<UserDataModel> users;

  UsersModel({required this.users});

  //copyWith
  UsersModel copyWith({List<UserDataModel>? users}) {
    return UsersModel(
      users: users ?? this.users,
    );
  }
}
