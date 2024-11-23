import 'package:flutter/material.dart';
import 'package:mobile_clean_check/widgets/widgets.dart';

class CcListScreenTemplate extends StatelessWidget {
  final String title;
  final Widget search;
  final Widget filters;
  final Widget symbology;
  final Widget content;

  const CcListScreenTemplate({
    required this.title,
    required this.search,
    required this.filters,
    required this.symbology,
    required this.content,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: CcTitleScreenWidget(title: title),
                ),
                search,
                filters,
                symbology,
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                child: content,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
