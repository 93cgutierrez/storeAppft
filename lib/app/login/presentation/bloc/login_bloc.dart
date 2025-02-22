import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:storeapp/app/login/presentation/model/login_form_model.dart';

import 'login_events.dart';
import 'login_states.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(InitialState()) {
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

  void _submitEvent(
    SubmitEvent event,
    Emitter<LoginState> emit,
  ) {}
}
