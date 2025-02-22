import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:storeapp/app/signup/presentation/pages/signup_page.dart';

import 'home/presentation/page/home_page.dart';
import 'login/presentation/page/login_page.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    final GoRouter router = GoRouter(
      initialLocation: LoginPage.link,
      routes: [
        GoRoute(
          path: LoginPage.link,
          name: LoginPage.name,
          builder: (context, state) => LoginPage(),
        ),
        GoRoute(
          path: SignupPage.link,
          name: SignupPage.name,
          builder: (context, state) => SignupPage(),
        ),
        GoRoute(
          path: HomePage.link,
          name: HomePage.name,
          builder: (context, state) => HomePage(),
        ),
        //Add more routes here ...
      ],
    );
    return MaterialApp.router(
      routerConfig: router,
      title: 'Store App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
