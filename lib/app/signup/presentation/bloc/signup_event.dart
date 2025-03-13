sealed class SignupEvent {}

//name
final class SignupNameChangedEvent extends SignupEvent {
  final String name;

  SignupNameChangedEvent({required this.name});
}

//document
final class SignupDocumentChangedEvent extends SignupEvent {
  final String document;

  SignupDocumentChangedEvent({required this.document});
}

//email
final class SignupEmailChangedEvent extends SignupEvent {
  final String email;

  SignupEmailChangedEvent({required this.email});
}

//password
final class SignupPasswordChangedEvent extends SignupEvent {
  final String confirmPassword;
  final String password;

  SignupPasswordChangedEvent({
    required this.password,
    required this.confirmPassword,
  });
}

//confirm password
final class SignupConfirmPasswordChangedEvent extends SignupEvent {
  final String confirmPassword;
  final String password;

  SignupConfirmPasswordChangedEvent({
    required this.password,
    required this.confirmPassword,
  });

  bool get isValid => password == confirmPassword;

  String get errorMessage => 'Las contraseñas no coinciden';
}

//imageProfileUrl
final class SignupImageProfileUrlChangedEvent extends SignupEvent {
  final String imageProfileUrl;

  SignupImageProfileUrlChangedEvent({required this.imageProfileUrl});
}

//submit
final class SignupSubmitEvent extends SignupEvent {
  SignupSubmitEvent();
}
