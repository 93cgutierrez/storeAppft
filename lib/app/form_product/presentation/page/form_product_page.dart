import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:storeapp/app/di/dependency_injection.dart';
import 'package:storeapp/app/home/presentation/page/home_page.dart';
import 'package:storeapp/app/login/presentation/bloc/login_bloc.dart';
import 'package:storeapp/app/login/presentation/bloc/login_events.dart';
import 'package:storeapp/app/login/presentation/bloc/login_states.dart';
import 'package:storeapp/app/shared/widget/password_input_field_widget.dart';
import 'package:storeapp/app/util/keyboard.util.dart';
import 'package:storeapp/app/util/log.util.dart';
import 'package:storeapp/app/util/validation.util.dart';

class FormProductPage extends StatelessWidget {
  static const String name = 'FormProductPage';
  static const String _tag = name;
  static const String link = '/$name';

  final GlobalKey<FormState> _formLoginPageKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  FormProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: DependencyInjection.serviceLocator<LoginBloc>(),
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.blue,
            title: Text(
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              'Agregar producto',
            ),
            centerTitle: true,
            leading: IconButton(
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.pop(context); // Navigate back
              },
            ),
          ),
          resizeToAvoidBottomInset: false,
          body: Column(
            spacing: 20,
            children: [
              BodyLoginWidget(
                  formLoginPageKey: _formLoginPageKey,
                  usernameController: _usernameController,
                  passwordController: _passwordController,
                  tag: _tag),
            ],
          ),
        ),
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
    final LoginBloc bloc = context.read<LoginBloc>();
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        switch (state) {
          case InitialState() || DataUpdatedState():
            break;
          case LoginSuccessState():
            Log.d(widget._tag, 'Login success');
            GoRouter.of(context).pushReplacement(HomePage.link);
            break;
          case LoginErrorState():
            Log.d(widget._tag, 'Login error');
            showDialog(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                      title: const Text(
                        'Error de inicio de sesión',
                      ),
                      content: Text(
                        state.errorMessage.toString(),
                      ),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () {
                            GoRouter.of(context).pop();
                            //Navigator.of(context).pop();
                          },
                          child: const Text('OK'),
                        ),
                      ],
                    ));

            break;
        }
      },
      child: BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
          final bool isValidForm = validateEmail(state.model.email) == null &&
              validatePassword(state.model.password) == null;
          widget._usernameController.text = state.model.email;
          widget._passwordController.text = state.model.password;
          return Expanded(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 32.0),
              child: Form(
                key: widget._formLoginPageKey,
                child: Column(
                  spacing: 20,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    state.model.email.isEmpty && state.model.password.isEmpty
                        ? CircularProgressIndicator()
                        : Text(
                            "Result: ${state is LoginSuccessState ? state.success : "N/A"}"),
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
                        //setState(() {
                        widget._usernameController.text = value.trim();
                        bloc.add(
                          EmailChangedEvent(
                            email: widget._usernameController.text,
                          ),
                        );
                        //});
                      },
                    ),
                    PasswordInputFieldWidget(
                      autoValidateMode: AutovalidateMode.onUserInteraction,
                      controller: widget._passwordController,
                      icon: Icon(Icons.lock),
                      labelText: 'Contraseña',
                      hintText: 'Ingrese su contraseña',
                      onChanged: (value) {
                        //setState(() {
                        widget._passwordController.text = value.trim();
                        bloc.add(
                          PasswordChangedEvent(
                            password: widget._passwordController.text,
                          ),
                        );
                        //});
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
                                bloc.add(SubmitEvent());
                              }
                            : null,
                        child: Text('Inicio de Sesión'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
