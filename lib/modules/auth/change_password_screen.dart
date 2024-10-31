import 'package:flutter/material.dart';
import 'package:mobile_clean_check/widgets/widgets.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  @override
  Widget build(BuildContext context) {
    return const CcAuthTemplate(contentForm: CcChangePasswordFormWidget());
  }
}
