import 'package:storeapp/app/signup/presentation/model/profile_model.dart';

sealed class SignupState {
  final ProfileModel model;

  const SignupState({required this.model});
}

final class SignupInitial extends SignupState {
  SignupInitial()
      : super(
          model:
              //ProfileModel.empty(),
              //TODO: TEMPORAL FOR TESTING
              ProfileModel(
            id: '',
            name: 'John Doe',
            document: '123456',
            email: 'iooo@gmail.com',
            password: '456789',
            confirmPassword: '456789',
            imageProfileUrl:
                'https://static.vecteezy.com/system/resources/thumbnails/001/993/889/small_2x/beautiful-latin-woman-avatar-character-icon-free-vector.jpg',
          ),
        );
}

//DataUpdatedState
final class DataUpdatedState extends SignupState {
  const DataUpdatedState({required super.model});
}

//signUpSuccessState
final class SignUpSuccessState extends SignupState {
  final bool success;

  const SignUpSuccessState({
    required super.model,
    required this.success,
  });
}

//ErrorState
final class SignUpErrorState extends SignupState {
  final Exception errorMessage;

  const SignUpErrorState({
    required super.model,
    required this.errorMessage,
  });
}
