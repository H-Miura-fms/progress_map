import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextButton(
        child: Text("home"),
        onPressed: () {
          context.go('/home');
        },
      ),
    );
  }
}
