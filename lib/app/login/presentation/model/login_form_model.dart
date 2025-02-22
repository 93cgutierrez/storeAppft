final class LoginFormModel {
  final String email;
  final String password;

  LoginFormModel({
    required this.email,
    required this.password,
  });

  LoginFormModel copyWith({
    String? email,
    String? password,
  }) {
    return LoginFormModel(
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }

  @override
  String toString() {
    return 'LoginFormModel(email: $email, password: $password)';
  }
}
