import 'package:flutter/material.dart';

class CcBottomSheetTemplate extends StatelessWidget {
  final String title;
  final String subtitle;
  final Widget content;
  final Widget actions;

  const CcBottomSheetTemplate({
    required this.title,
    required this.subtitle,
    required this.content,
    required this.actions,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 32.0, horizontal: 16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16.0),
          Text(
            subtitle,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(height: 16.0),
          Flexible(
            child: content,
          ),
          const SizedBox(height: 16.0),
          actions,
        ],
      ),
    );
  }
}
