import 'package:flutter/material.dart';

class KeyboardUtil {
  //hide keyboard
  static void hide(BuildContext context) {
    FocusScope.of(context).requestFocus(FocusNode());
  }
}
