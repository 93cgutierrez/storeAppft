mixin Validation {
  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor ingrese su usuario';
    }
    /* if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
      return 'Formato de correo electrónico inválido';
    }*/
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor ingrese su contraseña';
    }
/*    if (value.length < 6) {
      return 'La contraseña debe tener al menos 6 caracteres';
    }*/
    return null;
  }
}
