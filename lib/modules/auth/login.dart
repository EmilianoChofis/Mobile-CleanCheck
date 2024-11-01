import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('CleanCheck', style: Theme.of(context).textTheme.headlineLarge),
            Text('CleanCheck', style: Theme.of(context).textTheme.headlineSmall),
            Text('CleanCheck', style: Theme.of(context).textTheme.bodyLarge),
          ],
        ),
      ),
    );
  }
}
