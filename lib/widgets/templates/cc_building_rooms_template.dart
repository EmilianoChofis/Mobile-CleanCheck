import 'package:flutter/material.dart';
import 'package:mobile_clean_check/core/theme/themes.dart';
import 'package:mobile_clean_check/widgets/atoms/cc_title_screen_widget.dart';

class CcBuildingRoomsTemplate extends StatelessWidget {
  final Widget header;
  final String title;
  final Widget filters;
  final Widget actions;
  final Widget content;

  const CcBuildingRoomsTemplate({
    required this.header,
    required this.title,
    required this.filters,
    required this.actions,
    required this.content,
    super.key,
  });

  final primaryColor = ColorSchemes.primary;
  final surfaceColor = ColorSchemes.white;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
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
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: CcTitleScreenWidget(title: title),
                  ),
                  filters,
                  Expanded(
                    child: content,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomSheet: Padding(
        padding: const EdgeInsets.all(8.0),
        child: actions,
      ),
    );
  }
}
