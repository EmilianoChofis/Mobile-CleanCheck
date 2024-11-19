import 'package:flutter/material.dart';
import 'package:mobile_clean_check/core/theme/themes.dart';

class CcHomeTemplate extends StatefulWidget {
  final Widget header;
  final Widget content;

  const CcHomeTemplate({
    required this.header,
    required this.content,
    super.key,
  });

  @override
  State<CcHomeTemplate> createState() => _CcHomeTemplateState();
}

class _CcHomeTemplateState extends State<CcHomeTemplate> {
  final primaryColor = ColorSchemes.primary;
  final surfaceColor = ColorSchemes.white;

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
          child: widget.header,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: widget.content,
        ),
      ],
    );
  }
}
