import 'package:flutter/material.dart';

class CcBottomSheetTemplate extends StatelessWidget {
  final String title;
  final String? subtitle;
  final Widget content;
  final Widget actions;

  const CcBottomSheetTemplate({
    required this.title,
    this.subtitle,
    required this.content,
    required this.actions,
    super.key,
  });

  static const _titleTextStyle =
      TextStyle(fontSize: 16, fontWeight: FontWeight.bold);

  static const _subtitleTextStyle =
      TextStyle(fontSize: 16, fontWeight: FontWeight.w400);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 32.0, horizontal: 16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildTitle(),
          const SizedBox(height: 16.0),
          if (subtitle != null) _buildSubtitle(),
          Flexible(child: content),
          const SizedBox(height: 16.0),
          actions,
        ],
      ),
    );
  }

  Widget _buildTitle() {
    return Text(title, style: _titleTextStyle);
  }

  Widget _buildSubtitle() {
    return Column(
      children: [
        Text(
          subtitle!,
          style: _subtitleTextStyle,
        ),
        const SizedBox(height: 16.0),
      ],
    );
  }
}
