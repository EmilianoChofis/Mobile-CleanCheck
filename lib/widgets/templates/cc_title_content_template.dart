import 'package:flutter/material.dart';
import 'package:mobile_clean_check/widgets/widgets.dart';

class CcTitleContentTemplate extends StatelessWidget {
  final String title;
  final Widget content;

  const CcTitleContentTemplate({
    required this.title,
    required this.content,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CcTitleScreenWidget(title: title),
          const SizedBox(height: 8.0),
          content,
        ],
      ),
    );
  }
}
