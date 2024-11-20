import 'package:flutter/material.dart';
import 'package:mobile_clean_check/widgets/widgets.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  @override
  Widget build(BuildContext context) {
    return const CcAuthTemplate(contentForm: CcForgotPasswordFormWidget());
  }
}

