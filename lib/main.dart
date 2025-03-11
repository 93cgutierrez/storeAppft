import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:storeapp/app/main_app.dart';

import 'app/di/dependency_injection.dart';

Future<void> main() async {
  DependencyInjection.setup();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MainApp());
}
