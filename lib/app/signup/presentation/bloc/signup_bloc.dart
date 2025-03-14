import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:storeapp/app/signup/domain/use_case/create_user_use_case.dart';
import 'package:storeapp/app/signup/presentation/bloc/signup_event.dart';
import 'package:storeapp/app/signup/presentation/bloc/signup_state.dart';
import 'package:storeapp/app/signup/presentation/model/profile_model.dart';
import 'package:storeapp/app/util/log.util.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  final String _tag = 'SignupBloc';
  final CreateUserUseCase createUserUseCase;

  SignupBloc({required this.createUserUseCase}) : super(SignupInitial()) {
    on<SignupNameChangedEvent>(_nameChangedEvent);
    on<SignupDocumentChangedEvent>(_documentChangedEvent);
    on<SignupEmailChangedEvent>(_emailChangedEvent);
    on<SignupPasswordChangedEvent>(_passwordChangedEvent);
    on<SignupConfirmPasswordChangedEvent>(_confirmPasswordChangedEvent);
    on<SignupImageProfileUrlChangedEvent>(_imageProfileUrlChangedEvent);
    on<SignupSubmitEvent>(_submitEvent);
  }

  Future<void> _nameChangedEvent(
    SignupNameChangedEvent event,
    Emitter<SignupState> emit,
  ) async {
    final ProfileModel newData = state.model.copyWith(
      name: event.name,
    );
    final DataUpdatedState newState = DataUpdatedState(
      model: newData,
    );
    emit(newState);
  }

  Future<void> _documentChangedEvent(
    SignupDocumentChangedEvent event,
    Emitter<SignupState> emit,
  ) async {
    final ProfileModel newData = state.model.copyWith(
      document: event.document,
    );
    final DataUpdatedState newState = DataUpdatedState(
      model: newData,
    );
    emit(newState);
  }

  Future<void> _emailChangedEvent(
    SignupEmailChangedEvent event,
    Emitter<SignupState> emit,
  ) async {
    final ProfileModel newData = state.model.copyWith(
      email: event.email,
    );
    final DataUpdatedState newState = DataUpdatedState(
      model: newData,
    );
    emit(newState);
  }

  Future<void> _passwordChangedEvent(
    SignupPasswordChangedEvent event,
    Emitter<SignupState> emit,
  ) async {
    final ProfileModel newData = state.model.copyWith(
      password: event.password,
    );
    final DataUpdatedState newState = DataUpdatedState(
      model: newData,
    );
    emit(newState);
  }

  Future<void> _confirmPasswordChangedEvent(
    SignupConfirmPasswordChangedEvent event,
    Emitter<SignupState> emit,
  ) async {
    final ProfileModel newData = state.model.copyWith(
      confirmPassword: event.confirmPassword,
    );
    final DataUpdatedState newState = DataUpdatedState(
      model: newData,
    );
    emit(newState);
  }

  Future<void> _imageProfileUrlChangedEvent(
    SignupImageProfileUrlChangedEvent event,
    Emitter<SignupState> emit,
  ) async {
    final ProfileModel newData = state.model.copyWith(
      imageProfileUrl: event.imageProfileUrl,
    );
    final DataUpdatedState newState = DataUpdatedState(
      model: newData,
    );
    emit(newState);
  }

  Future<void> _submitEvent(
    SignupSubmitEvent event,
    Emitter<SignupState> emit,
  ) async {
    try {
      final bool success = await createUserUseCase.invoke(
        profileModel: state.model,
      );
      if (success) {
        final SignUpSuccessState newState = SignUpSuccessState(
          model: state.model,
          success: success,
        );
        emit(newState);
        Log.d(_tag, 'User created successfully');
        //clean model
        final DataUpdatedState newState2 = DataUpdatedState(
          model: ProfileModel.empty(),
        );
        emit(newState2);
      } else {
        final SignUpErrorState newState = SignUpErrorState(
          model: state.model,
          errorMessage: Exception('Fallo al intentar crear el usuario'),
        );
        emit(newState);
      }
    } on Exception catch (error) {
      Log.e(_tag, 'Error: $error');
      final SignUpErrorState newState = SignUpErrorState(
        model: state.model,
        errorMessage: error,
      );
      emit(newState);
    }
  }
}
