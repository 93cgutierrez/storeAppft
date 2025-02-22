import 'dart:async';

import 'package:flutter/material.dart';
import 'package:storeapp/app/shared/util/validation.util.dart';

class PasswordInputFieldWidget extends StatefulWidget {
  PasswordInputFieldWidget({
    super.key,
    required this.controller,
    this.labelText,
    this.hintText,
    this.icon,
    this.autoValidateMode,
    this.onChanged,
  });

  final TextEditingController controller;
  final String? labelText;
  final String? hintText;
  final Icon? icon;
  final AutovalidateMode? autoValidateMode;
  void Function(String)? onChanged;

  @override
  _PasswordInputFieldWidgetState createState() =>
      _PasswordInputFieldWidgetState();
}

class _PasswordInputFieldWidgetState extends State<PasswordInputFieldWidget>
    with Validation {
  bool _passwordVisible = false;
  Timer? _autoShowTimer;

  @override
  void initState() {
    super.initState();
    _passwordVisible = false; // Initialize password visibility to hidden
  }

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  void dispose() {
    widget.controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autovalidateMode: widget.autoValidateMode,
      controller: widget.controller,
      obscureText: !_passwordVisible, // Toggle password visibility
      decoration: InputDecoration(
        icon: widget.icon,
        labelText: widget.labelText,
        hintText: widget.hintText,
        suffixIcon: IconButton(
          icon: Icon(
            _passwordVisible ? Icons.visibility : Icons.visibility_off,
          ),
          onPressed: () {
            _autoShowTimer?.cancel();
            if (!_passwordVisible) {
              _autoShowTimer = Timer(Duration(seconds: 5), () {
                setState(() {
                  _passwordVisible = false;
                });
              });
            }
            setState(() {
              _passwordVisible = !_passwordVisible;
            });
          },
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      validator: validatePassword,
      onChanged: widget.onChanged,
    );
  }
}
