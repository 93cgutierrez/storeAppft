import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:storeapp/app/login/domain/use_case/login_use_case.dart';
import 'package:storeapp/app/login/presentation/model/login_form_model.dart';
import 'package:storeapp/app/util/log.util.dart';

import 'login_events.dart';
import 'login_states.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final String _tag = 'LoginBloc';
  final LoginUseCase loginUseCase;

  LoginBloc({required this.loginUseCase}) : super(InitialState()) {
    on<EmailChangedEvent>(_emailChangedEvent);
    on<PasswordChangedEvent>(_passwordChangedEvent);
    on<SubmitEvent>(_submitEvent);
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

  Future<void> _submitEvent(
    SubmitEvent event,
    Emitter<LoginState> emit,
  ) async {
    try {
      final bool success = await loginUseCase.invoke(
        loginFormModel: state.model,
      );
      if (success) {
        final LoginSuccessState newState = LoginSuccessState(
          model: state.model,
          success: success,
        );
        emit(newState);
      } else {
        final LoginErrorState newState = LoginErrorState(
          model: state.model,
          errorMessage: Exception('Fallo al intentar iniciar sesión'),
        );
        emit(newState);
      }
    } catch (e) {
      Log.e(_tag, 'Error: $e');
      final LoginErrorState newState = LoginErrorState(
        model: state.model,
        errorMessage: e as Exception,
      );
      emit(newState);
    }
  }
}
