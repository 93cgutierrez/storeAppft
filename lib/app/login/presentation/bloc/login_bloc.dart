import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:storeapp/app/login/domain/use_case/login_use_case.dart';
import 'package:storeapp/app/login/presentation/model/login_form_model.dart';
import 'package:storeapp/app/util/log.util.dart';

import 'login_events.dart';
import 'login_states.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final String _tag = 'LoginBloc';
  late final LoginUseCase _loginUseCase;
  LoginBloc() : super(InitialState()) {
    on<EmailChangedEvent>(_emailChangedEvent);
    on<PasswordChangedEvent>(_passwordChangedEvent);
    on<SubmitEvent>(_submitEvent);

    _loginUseCase = LoginUseCase();
  }

  void _emailChangedEvent(
    EmailChangedEvent event,
    Emitter<LoginState> emit,
  ) {
    final LoginFormModel newData = state.model.copyWith(
      email: event.email,
    );
    final DataUpdatedState newState = DataUpdatedState(
      model: newData,
    );
    emit(newState);
  }

  void _passwordChangedEvent(
    PasswordChangedEvent event,
    Emitter<LoginState> emit,
  ) {
    final LoginFormModel newData = state.model.copyWith(
      password: event.password,
    );
    final DataUpdatedState newState = DataUpdatedState(
      model: newData,
    );
    emit(newState);
  }

  void _submitEvent(
    SubmitEvent event,
    Emitter<LoginState> emit,
  ) {
    try {
      final bool success = _loginUseCase.invoke(
        loginFormModel: state.model,
      );
      final LoginSuccessState newState = LoginSuccessState(
        model: state.model,
        success: success,
      );
      emit(newState);
    } catch (e) {
      Log.e(_tag, e.toString());
      final LoginErrorState newState = LoginErrorState(
        model: state.model,
        errorMessage: e as Exception,
      );
      emit(newState);
    }
  }
}
