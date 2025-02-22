import 'package:storeapp/app/login/presentation/model/login_form_model.dart';

sealed class LoginState {
  final LoginFormModel model;

  LoginState({
    required this.model,
  });
}

final class InitialState extends LoginState {
  InitialState()
      : super(
          model: LoginFormModel(
            email: '',
            password: '',
          ),
        );
}

final class DataUpdatedState extends LoginState {
  DataUpdatedState({
    required super.model,
  });
}
