import 'package:flutter_bloc/flutter_bloc.dart';

import 'login_events.dart';
import 'login_states.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(InitialState()) {
    on<EmailChangedEvent>(handler);
    on<PasswordChangedEvent>(handler);
    on<SubmitEvent>(handler);
  }
}
