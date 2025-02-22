import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:storeapp/app/util/validation.util.dart';
import 'package:storeapp/app/shared/widget/password_input_field_widget.dart';
import 'package:storeapp/app/signup/presentation/pages/signup_page.dart';
import 'package:storeapp/app/util/keyboard.util.dart';
import 'package:storeapp/app/util/log.util.dart';

class LoginPage extends StatelessWidget {
  static const String name = 'loginPage';
  static const String _tag = name;
  static const String link = '/$name';

  final GlobalKey<FormState> _formLoginPageKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    //safeArea: widget in Flutter is crucial for handling situations where parts of your app's UI might be obscured by system elements like the status bar, notches, or other intrusions.
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Column(
          spacing: 20,
          children: [
            HeaderLoginWidget(),
            Expanded(
              child: BodyLoginWidget(
                  formLoginPageKey: _formLoginPageKey,
                  usernameController: _usernameController,
                  passwordController: _passwordController,
                  tag: _tag),
            ),
            FooterLoginWidget(tag: _tag),
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
      child: Column(
        spacing: 20,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.network(
            'https://picsum.photos/600/700?random=1',
            width: double.infinity,
            height: 150,
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

class BodyLoginWidget extends StatefulWidget {
  BodyLoginWidget({
    super.key,
    required GlobalKey<FormState> formLoginPageKey,
    required TextEditingController usernameController,
    required TextEditingController passwordController,
    required String tag,
  })  : _formLoginPageKey = formLoginPageKey,
        _usernameController = usernameController,
        _passwordController = passwordController,
        _tag = tag;

  final GlobalKey<FormState> _formLoginPageKey;
  final TextEditingController _usernameController;
  final TextEditingController _passwordController;
  final String _tag;

  @override
  State<BodyLoginWidget> createState() => _BodyLoginWidgetState();
}

class _BodyLoginWidgetState extends State<BodyLoginWidget> with Validation {
  @override
  Widget build(BuildContext context) {
    final bool isValidForm =
        widget._formLoginPageKey.currentState?.validate() ?? false;
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 32.0),
      child: Form(
        key: widget._formLoginPageKey,
        child: Column(
          spacing: 20,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              controller: widget._usernameController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                icon: Icon(Icons.person),
                labelText: 'Usuario',
                hintText: 'Ingrese su usuario',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              validator: validateEmail,
              onChanged: (value) {
                setState(() {
                  widget._usernameController.text = value.trim();
                });
              },
            ),
            PasswordInputFieldWidget(
              autoValidateMode: AutovalidateMode.onUserInteraction,
              controller: widget._passwordController,
              icon: Icon(Icons.lock),
              labelText: 'Contraseña',
              hintText: 'Ingrese su contraseña',
              onChanged: (value) {
                setState(() {
                  widget._passwordController.text = value.trim();
                });
              },
            ),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: isValidForm
                    ? () {
                        Keyboard.hide(context);
                        Log.d(
                            widget._tag,
                            'Login button pressed username: ${widget._usernameController.text} '
                            'password: ${widget._passwordController.text}');
                        //TODO: CG 20250215 Validate username and password
                      }
                    : null,
                child: Text('Inicio de Sesión'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FooterLoginWidget extends StatelessWidget {
  const FooterLoginWidget({
    super.key,
    required String tag,
  }) : _tag = tag;

  final String _tag;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100.0,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 32.0),
        child: Column(
          children: [
            Divider(),
            Row(
              spacing: 20.0,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('¿No tienes una cuenta?'),
                TextButton(
                  style: ButtonStyle(
                    foregroundColor:
                        WidgetStateProperty.all<Color>(Colors.blueAccent),
                  ),
                  onPressed: () {
                    Log.d(_tag, 'Register button pressed');
                    GoRouter.of(context).push(SignupPage.link);
                  },
                  child: Text('Registrate acá'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
