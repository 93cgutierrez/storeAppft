import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:storeapp/app/login/presentation/page/login_page.dart';

class HomePage extends StatelessWidget {
  static const String name = 'HomePage';
  static const String _tag = name;
  static const String link = '/$name';

  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          spacing: 20,
          children: [
            Text(
              'This is the Home Page',
              style: TextStyle(fontSize: 24),
            ),
            OutlinedButton(
                onPressed: () {
                  GoRouter.of(context).pushReplacement(LoginPage.link);
                },
                child: Text('Cerrar sesión'))
          ],
        ),
      ),
    );
  }
}
