import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mobile_clean_check/core/theme/themes.dart';

class CcWelcomeHomeTemplate extends StatefulWidget {
  final Widget actions;

  const CcWelcomeHomeTemplate({required this.actions, super.key});

  @override
  State<CcWelcomeHomeTemplate> createState() => _CcWelcomeHomeTemplateState();
}

class _CcWelcomeHomeTemplateState extends State<CcWelcomeHomeTemplate> {
  final primaryColor = ColorSchemes.primary;
  final surfaceColor = ColorSchemes.white;
  String? userName;

  @override
  void initState() {
    super.initState();
    _getUserName();
  }

  Future<void> _getUserName() async {
    final prefs = await SharedPreferences.getInstance();
    List<String>? name = prefs.getString('user')?.split(' ');
    setState(() => userName = name?[0]);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'Hola ${userName ?? 'Usuario'}, ¿Qué quieres hacer?',
          style: TextStyle(color: surfaceColor, fontSize: 16),
        ),
        widget.actions,
      ],
    );
  }
}
