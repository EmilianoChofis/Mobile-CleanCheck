import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mobile_clean_check/core/theme/themes.dart';

class CcHomeTemplate extends StatefulWidget {
  final Widget actions;
  final Widget content;

  const CcHomeTemplate(
      {required this.actions, required this.content, super.key});

  @override
  State<CcHomeTemplate> createState() => _CcHomeTemplateState();
}

class _CcHomeTemplateState extends State<CcHomeTemplate> {
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
    setState(() => userName = prefs.getString('user'));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(8.0),
          width: double.infinity,
          decoration: BoxDecoration(
            color: primaryColor,
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(20.0),
              bottomRight: Radius.circular(20.0),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Hola ${userName ?? 'Usuario'}, ¿Qué quieres hacer?',
                style: TextStyle(color: surfaceColor),
              ),
              widget.actions,
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: widget.content,
        ),
      ],
    );
  }
}
