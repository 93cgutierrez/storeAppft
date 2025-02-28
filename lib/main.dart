import 'package:flutter/material.dart';
import 'package:storeapp/app/main_app.dart';

import 'app/di/dependency_injection.dart';

void main() {
  DependencyInjection.setup();
  runApp(const MainApp());
}
