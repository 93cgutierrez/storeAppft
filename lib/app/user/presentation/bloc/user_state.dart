import 'package:storeapp/app/user/presentation/model/users_model.dart';

sealed class UserState {
  final UsersModel model;

  const UserState({required this.model});
}

final class UserInitial extends UserState {
  UserInitial() : super(model: UsersModel(users: []));
}

final class UserEmptyState extends UserState {
  UserEmptyState() : super(model: UsersModel(users: []));
}

//loading
final class UserLoadingState extends UserState {
  final String message;

  UserLoadingState({this.message = "Cargando Usuarios..."})
      : super(model: UsersModel(users: []));
}

//error
final class UserErrorState extends UserState {
  const UserErrorState({required super.model, required this.message});

  final String message;
}

final class UserLoadDataState extends UserState {
  const UserLoadDataState({required super.model});
}

//logout
final class UserLogoutState extends UserState {
  UserLogoutState() : super(model: UsersModel(users: []));
}
