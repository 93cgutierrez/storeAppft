class ProfileModel {
  String name;
  String email;
  String password;
  String imageProfileUrl;

  ProfileModel({
    required this.name,
    required this.email,
    required this.password,
    required this.imageProfileUrl,
  });

  ProfileModel copyWith({
    String? name,
    String? email,
    String? password,
    String? confirmPassword,
    String? imageProfileUrl,
  }) {
    return ProfileModel(
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      imageProfileUrl: imageProfileUrl ?? this.imageProfileUrl,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'password': password,
      'imageProfileUrl': imageProfileUrl,
    };
  }

  factory ProfileModel.fromMap(Map<String, dynamic> map) {
    return ProfileModel(
      name: map['name'],
      email: map['email'],
      password: map['password'],
      imageProfileUrl: map['imageProfileUrl'],
    );
  }

  //toString
  @override
  String toString() {
    return 'ProfileModel(name: $name, email: $email, password: $password, imageProfileUrl: $imageProfileUrl)';
  }
}
