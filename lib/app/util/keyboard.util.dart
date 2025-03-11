import 'package:flutter/material.dart';

class Keyboard {
  //hide keyboard
  static void hide(BuildContext context) {
    FocusScope.of(context).requestFocus(FocusNode());
  }
}
