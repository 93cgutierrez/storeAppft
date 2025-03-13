import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:storeapp/app/shared/widget/password_input_field_widget.dart';
import 'package:storeapp/app/signup/presentation/bloc/signup_bloc.dart';
import 'package:storeapp/app/signup/presentation/model/profile_model.dart';
import 'package:storeapp/app/util/log.util.dart';
import 'package:storeapp/app/util/validation.util.dart';

import '../bloc/signup_bloc.dart';

const String _tag = 'SignupPage';

class SignupPage extends StatefulWidget {
  static const String name = 'SignupPage';
  static const String link = '/$name';

  SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  //key
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  //controller
  final TextEditingController _nameController = TextEditingController();

  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  final TextEditingController _confirmPasswordController =
      TextEditingController();

  final TextEditingController _imageProfileUrlController =
      TextEditingController();

  //initialization
  @override
  void initState() {
    super.initState();
    Log.d(_tag, 'initState');
    //load initial data
    _loadInitialData();
  }

  //dispose
  @override
  void dispose() {
    super.dispose();
    Log.d(_tag, 'dispose');
    //dispose controllers
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _imageProfileUrlController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //TODO: 20250213 homework
    //name
    //email
    //password
    //confirm password
    //imageProfileUrl
    //imageview render before url
    //sign up button
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: Text(
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
            'Registro',
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
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              spacing: 20,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                BodySignupWidget(
                  formKey: _formKey,
                  nameController: _nameController,
                  emailController: _emailController,
                  passwordController: _passwordController,
                  confirmPasswordController: _confirmPasswordController,
                  imageProfileUrlController: _imageProfileUrlController,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _loadInitialData() {
    Log.d(_tag, '_loadInitialData');
    //load initial data
    //_nameController.text = 'John Doe';
    //_emailController.text = 'john.doe@example.com';
    //_passwordController.text = 'password';
    //_confirmPasswordController.text = 'password';
    _imageProfileUrlController.text = 'https://picsum.photos/600/700?random=1';
  }
}

class BodySignupWidget extends StatefulWidget {
  const BodySignupWidget({
    super.key,
    required GlobalKey<FormState> formKey,
    required TextEditingController nameController,
    required TextEditingController emailController,
    required TextEditingController passwordController,
    required TextEditingController confirmPasswordController,
    required TextEditingController imageProfileUrlController,
  })  : _formKey = formKey,
        _nameController = nameController,
        _emailController = emailController,
        _passwordController = passwordController,
        _confirmPasswordController = confirmPasswordController,
        _imageProfileUrlController = imageProfileUrlController;

  final GlobalKey<FormState> _formKey;
  final TextEditingController _nameController;
  final TextEditingController _emailController;
  final TextEditingController _passwordController;
  final TextEditingController _confirmPasswordController;
  final TextEditingController _imageProfileUrlController;

  @override
  State<BodySignupWidget> createState() => _BodySignupWidgetState();
}

class _BodySignupWidgetState extends State<BodySignupWidget> with Validation {
  @override
  Widget build(BuildContext context) {
    final SignupBloc = context.read<SignupBloc>();
    return BlocConsumer<SignupBloc, SignupState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return Container(
          margin: EdgeInsets.symmetric(horizontal: 32.0),
          child: Form(
            key: widget._formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              spacing: 20,
              children: [
                //Load image from URL
                Image.network(
                  widget._imageProfileUrlController.text,
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    Log.e(_tag, 'Error loading image: $error');
                    return Icon(Icons.error, size: 100, color: Colors.red);
                  },
                ),
                //name
                TextFormField(
                  controller: widget._nameController,
                  decoration: InputDecoration(
                    icon: Icon(Icons.person),
                    labelText: 'Nombre',
                    hintText: 'Ingrese su nombre',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onChanged: (value) {
                    widget._nameController.text = value;
                  },
                ),
                //email
                TextFormField(
                  controller: widget._emailController,
                  decoration: InputDecoration(
                    icon: Icon(Icons.email),
                    labelText: 'Email',
                    hintText: 'Ingrese su email',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  validator: validateEmail,
                ),
                //password
                PasswordInputFieldWidget(
                  controller: widget._passwordController,
                  icon: Icon(Icons.lock),
                  labelText: 'Contraseña',
                  hintText: 'Ingrese su contraseña',
                ),
                //confirm password
                PasswordInputFieldWidget(
                  controller: widget._confirmPasswordController,
                  icon: Icon(Icons.lock),
                  labelText: 'Confirmar Contraseña',
                  hintText: 'Confirme su contraseña',
                ),
                //imageProfileUrl
                TextFormField(
                  maxLines: 2,
                  //not allowed enter new line
                  keyboardType: TextInputType.text,
                  controller: widget._imageProfileUrlController,
                  decoration: InputDecoration(
                    icon: Icon(Icons.image),
                    labelText: 'URL de la imagen de perfil',
                    hintText: 'Ingrese la URL de la imagen de perfil',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onChanged: (String value) {
                    setState(() {
                      widget._imageProfileUrlController.text = value;
                    });
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton(
                    onPressed: () {
                      if (widget._formKey.currentState!.validate()) {
                        // El formulario es válido, procesar los datos
                      }
                      // Handle sign up logic here
                      Log.d(_tag, 'Sign up button pressed');
                      _validateAndSaveProfile(
                        name: widget._nameController.text,
                        email: widget._emailController.text,
                        password: widget._passwordController.text,
                        confirmPassword: widget._confirmPasswordController.text,
                        imageProfileUrl: widget._imageProfileUrlController.text,
                      );
                    },
                    child: Text('Registrarse'),
                  ),
                ),
                /*          OutlinedButton(
              onPressed: () {
                // Navigate to the login page with goRouter
                GoRouter.of(context).pop();
              },
              child: Text('Ir a login'),
            ),*/
              ],
            ),
          ),
        );
      },
    );
  }

  bool _validateAndSaveProfile({
    required String name,
    required String email,
    required String password,
    required String confirmPassword,
    required String imageProfileUrl,
  }) {
    if (widget._nameController.text.isEmpty ||
        widget._emailController.text.isEmpty ||
        widget._passwordController.text.isEmpty ||
        widget._confirmPasswordController.text.isEmpty ||
        widget._imageProfileUrlController.text.isEmpty) {
      //show snackbar
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Todos los campos son obligatorios'),
        ),
      );
      Log.d(_tag, 'All fields are required');
      return false;
    }
    if (widget._passwordController.text !=
        widget._confirmPasswordController.text) {
      //show snackbar
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Las contraseñas no coinciden'),
        ),
      );
      Log.d(_tag, 'Passwords do not match');
      return false;
    }

    ProfileModel profile = ProfileModel(
      name: widget._nameController.text,
      document: widget._documentController.text,
      email: widget._emailController.text,
      password: widget._passwordController.text,
      imageProfileUrl: widget._imageProfileUrlController.text,
    );
    Log.d(_tag, 'Profile: $profile');
    //TODO: 20250218 PENDING SAVE PROFILE
    return true;
  }
}
