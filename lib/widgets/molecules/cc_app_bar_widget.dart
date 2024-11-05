import 'package:flutter/material.dart';
import 'package:mobile_clean_check/core/theme/color_schemes.dart';

class CcAppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool? centerTitle;
  final List<Widget>? actions;

  const CcAppBarWidget({
    required this.title,
    this.centerTitle = true,
    this.actions,
    super.key,
  });

  @override
  Size get preferredSize => const Size.fromHeight(56.0);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      foregroundColor: ColorSchemes.white,
      backgroundColor: ColorSchemes.primary,
      centerTitle: centerTitle,
      actions: actions,
    );
  }
}
