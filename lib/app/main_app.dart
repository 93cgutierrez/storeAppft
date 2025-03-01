import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:storeapp/app/form_product/presentation/pages/form_product_page.dart';
import 'package:storeapp/app/home/presentation/pages/home_page.dart';
import 'package:storeapp/app/signup/presentation/pages/signup_page.dart';

import 'login/presentation/page/login_page.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    final GoRouter router = GoRouter(
      initialLocation: HomePage.link,
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
        GoRoute(
          path: FormProductPage.link,
          name: FormProductPage.name,
          builder: (context, state) => FormProductPage(),
        ),
        //TODO: EDIT PAGE
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
