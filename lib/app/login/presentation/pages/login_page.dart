import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    //safeArea: widget in Flutter is crucial for handling situations where parts of your app's UI might be obscured by system elements like the status bar, notches, or other intrusions.
    return SafeArea(
      child: Scaffold(
        body: Container(
          color: Colors.deepOrangeAccent,
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Hello World!',
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 80,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Image.network(
                'https://picsum.photos/200/300?random=1',
                width: 250,
                height: 250,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
