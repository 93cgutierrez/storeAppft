import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:storeapp/app/form_product/presentation/pages/form_product_page.dart';
import 'package:storeapp/app/home/presentation/pages/home_page.dart';
import 'package:storeapp/app/signup/presentation/pages/signup_page.dart';
import 'package:storeapp/app/user/presentation/pages/users_page.dart';
import 'package:storeapp/app/util/parameters.dart';

import 'di/dependency_injection.dart';
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
          redirect: (context, state) async {
            //call SharedPreferences from getIt
            final prefs =
                DependencyInjection.serviceLocator<SharedPreferences>();
            final bool isLogged =
                prefs.getBool(Parameters.isLoggedKey) ?? false;
            if (isLogged) {
              return HomePage.link;
            }
            return null;
          },
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
          redirect: (context, state) async {
            //call SharedPreferences from getIt
            final prefs =
                DependencyInjection.serviceLocator<SharedPreferences>();
            final bool isLogged =
                prefs.getBool(Parameters.isLoggedKey) ?? false;
            if (!isLogged) {
              return LoginPage.link;
            }
            return null;
          },
        ),
        GoRoute(
          path: FormProductPage.link,
          name: FormProductPage.name,
          builder: (context, state) => FormProductPage(),
        ),
        GoRoute(
          path: FormProductPage.linkUpdate,
          name: FormProductPage.nameUpdate,
          builder: (context, state) =>
              FormProductPage(id: state.pathParameters[FormProductPage.idKey]),
        ),
        GoRoute(
          path: UsersPage.link,
          name: UsersPage.name,
          builder: (context, state) => UsersPage(),
        ),
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
