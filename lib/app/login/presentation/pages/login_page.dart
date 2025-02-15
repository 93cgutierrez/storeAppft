import 'package:flutter/material.dart';
import 'package:storeapp/app/util/log.dart';

class LoginPage extends StatelessWidget {
  static const String _tag = 'LoginPage';
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    //safeArea: widget in Flutter is crucial for handling situations where parts of your app's UI might be obscured by system elements like the status bar, notches, or other intrusions.
    return SafeArea(
      child: Scaffold(
        body: Column(
          spacing: 20,
          children: [
            HeaderLoginWidget(),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 32.0),
              child: Column(
                spacing: 20,
                children: [
                  TextField(
                    controller: _usernameController,
                    decoration: InputDecoration(
                      icon: Icon(Icons.person),
                      labelText: 'Usuario',
                      hintText: 'Ingrese su usuario',
                    ),
                  ),
                  PasswordInputField(
                    controller: _passwordController,
                    icon: Icon(Icons.key),
                    labelText: 'Contraseña',
                    hintText: 'Ingrese su contraseña',
                  ),
                  Text(
                    '¿No tienes una cuenta?',
                    style: TextStyle(
                      color: Colors.blue,
                    ),
                  ),
                  FilledButton(
                    onPressed: () {
                      Log.d(_tag,
                          'Login button pressed username: ${_usernameController.text} password: ${_passwordController.text}');
                    },
                    child: Text('Inicio de Sesión'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class HeaderLoginWidget extends StatelessWidget {
  const HeaderLoginWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250.0,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.network(
            'https://picsum.photos/200/300?random=1',
            width: double.infinity,
            height: 200,
            fit: BoxFit.fitWidth,
          ),
          Text(
            'Inicio de Sesión',
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: Colors.black,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

class PasswordInputField extends StatefulWidget {
  const PasswordInputField({
    super.key,
    required this.controller,
    this.labelText,
    this.hintText,
    this.icon,
  });

  final TextEditingController controller;
  final String? labelText;
  final String? hintText;
  final Icon? icon;

  @override
  _PasswordInputFieldState createState() => _PasswordInputFieldState();
}

class _PasswordInputFieldState extends State<PasswordInputField> {
  bool _passwordVisible = false;

  @override
  void initState() {
    super.initState();
    _passwordVisible = false; // Initialize password visibility to hidden
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      obscureText: !_passwordVisible, // Toggle password visibility
      decoration: InputDecoration(
        icon: widget.icon,
        labelText: widget.labelText,
        hintText: widget.hintText,
        suffixIcon: IconButton(
          icon: Icon(
            _passwordVisible ? Icons.visibility : Icons.visibility_off,
            color: Theme.of(context).primaryColorDark,
          ),
          onPressed: () {
            setState(() {
              _passwordVisible = !_passwordVisible;
            });
          },
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter a password';
        }
        if (value.length < 6) {
          return 'Password must be at least 6 characters';
        }
        return null;
      },
    );
  }
}
