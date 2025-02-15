import 'package:flutter/material.dart';

class PasswordInputFieldWidget extends StatefulWidget {
  const PasswordInputFieldWidget({
    super.key,
    required this.controller,
    this.labelText,
    this.hintText,
    this.icon,
  });

  final TextEditingController controller;
  final String? labelText;
  final String? hintText;
  final Icon? icon;

  @override
  _PasswordInputFieldWidgetState createState() =>
      _PasswordInputFieldWidgetState();
}

class _PasswordInputFieldWidgetState extends State<PasswordInputFieldWidget> {
  bool _passwordVisible = false;

  @override
  void initState() {
    super.initState();
    _passwordVisible = false; // Initialize password visibility to hidden
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
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
            setState(() {
              _passwordVisible = !_passwordVisible;
            });
          },
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
