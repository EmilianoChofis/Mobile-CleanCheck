import 'package:flutter/material.dart';
import 'package:mobile_clean_check/widgets/widgets.dart';

class CcBottomSheetTemplate extends StatelessWidget {
  final String title;
  final String subtitle;
  final Widget content;
  final VoidCallback onCancel;
  final VoidCallback onSave;

  const CcBottomSheetTemplate({
    required this.title,
    required this.subtitle,
    required this.content,
    required this.onCancel,
    required this.onSave,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
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
          Text(
            subtitle,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
          ),
          Flexible(
            child: content,
          ),
          Column(
            children: [
              CcButtonWidget(
                buttonType: ButtonType.elevated,
                onPressed: onSave,
                label: "Fijar habitaciones",
                isLoading: false,
              ),
              const SizedBox(height: 8.0),
              CcButtonWidget(
                buttonType: ButtonType.outlined,
                onPressed: onCancel,
                label: "Cancelar",
                isLoading: false,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
