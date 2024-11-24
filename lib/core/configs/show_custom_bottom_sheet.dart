import 'package:flutter/material.dart';
import 'package:mobile_clean_check/widgets/widgets.dart';

void showCustomBottomSheet(
    BuildContext context, {
      required String title,
      String? subtitle,
      required Widget content,
      required Widget actions,
    }) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    isDismissible: false,
    constraints: BoxConstraints(
      maxHeight: MediaQuery.of(context).size.height * 0.85,
    ),
    enableDrag: false,
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setModalState) {
          return CcBottomSheetTemplate(
            title: title,
            subtitle: subtitle,
            content: content,
            actions: actions,
          );
        },
      );
    },
  );
}
