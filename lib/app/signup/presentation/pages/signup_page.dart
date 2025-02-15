import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:storeapp/app/login/presentation/pages/login_page.dart';
import 'package:storeapp/app/util/log.dart';

class SignupPage extends StatelessWidget {
  static const String name = 'SignupPage';
  static const String _tag = name;
  static const String link = '/$name';
  const SignupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
          child: Column(
            spacing: 20,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              TextField(
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  // Handle sign up logic here
                  Log.d(_tag, 'Sign up button pressed');
                },
                child: Text('Sign Up'),
              ),
              OutlinedButton(
                onPressed: () {
                  // Navigate to the login page with goRouter
                  GoRouter.of(context).pop();
                },
                child: Text('Ir a login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
