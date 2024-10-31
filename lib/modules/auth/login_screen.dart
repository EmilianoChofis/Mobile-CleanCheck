import 'package:flutter/material.dart';
import 'package:mobile_clean_check/widgets/widgets.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginState();
}

class _LoginState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return const CcAuthTemplate(contentForm: CcLoginFormWidget());
  }
}
