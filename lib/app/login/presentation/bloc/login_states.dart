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
            //TODO: TEMPORAL FOR TESTING
/*            email: '',
            password: '',*/
            email: 'iooo@gmail.com',
            password: '456789',
          ),
        );
}

final class DataUpdatedState extends LoginState {
  DataUpdatedState({
    required super.model,
  });
}

//loginSuccessState
class LoginSuccessState extends LoginState {
  final bool success;

  LoginSuccessState({
    required super.model,
    required this.success,
  });
}

//LoginErrorState
class LoginErrorState extends LoginState {
  final Exception errorMessage;

  LoginErrorState({
    required super.model,
    required this.errorMessage,
  });
}
