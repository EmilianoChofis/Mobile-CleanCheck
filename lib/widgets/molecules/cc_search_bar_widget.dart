import 'package:flutter/material.dart';
import 'package:mobile_clean_check/core/theme/themes.dart';

class CcSearchBarWidget extends StatelessWidget {
  final SearchController controller;
  const CcSearchBarWidget({required this.controller, super.key});
  final primaryColor = ColorSchemes.primary;

  @override
  Widget build(BuildContext context) {
    return SearchBar(
      controller: controller,
      hintText: 'Buscar...',
      textStyle: WidgetStateProperty.all(
        TextStyle(color: primaryColor, fontWeight: FontWeight.w400),
      ),
      trailing: [Icon(Icons.search, color: primaryColor)],
      padding: const WidgetStatePropertyAll<EdgeInsets>(
        EdgeInsets.symmetric(horizontal: 16),
      ),
      elevation: WidgetStateProperty.all(0.0),
      side: WidgetStateProperty.all(BorderSide(color: primaryColor)),
    );
  }
}
