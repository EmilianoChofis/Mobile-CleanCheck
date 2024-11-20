import 'package:flutter/material.dart';
import 'package:mobile_clean_check/core/theme/themes.dart';

class CcHeaderTemplate extends StatelessWidget {
  final Widget header;
  final Widget content;

  const CcHeaderTemplate({
    required this.header,
    required this.content,
    super.key,
  });

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
          child: header,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: content,
        ),
      ],
    );
  }
}
