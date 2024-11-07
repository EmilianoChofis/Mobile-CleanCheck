import 'package:flutter/material.dart';
import 'package:mobile_clean_check/widgets/atoms/cc_loader_widget.dart';

class CcButtonWidget extends StatelessWidget {
  final String label;
  final Icon? suffixIcon;
  final Icon? prefixIcon;
  final bool isLoading;
  final VoidCallback? onPressed;
  final ButtonType buttonType;

  const CcButtonWidget({
    required this.label,
    this.suffixIcon,
    this.prefixIcon,
    required this.isLoading,
    required this.onPressed,
    required this.buttonType,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final button = _buildButton();
    return button;
  }

  Widget _buildButton() {
    switch (buttonType) {
      case ButtonType.elevated:
        return ElevatedButton(
          onPressed: isLoading ? null : onPressed,
          child: isLoading ? const CcLoaderWidget() : _buildButtonContent(),
        );
      case ButtonType.outlined:
        return OutlinedButton(
          onPressed: isLoading ? null : onPressed,
          child: isLoading ? const CcLoaderWidget() : _buildButtonContent(),
        );
      case ButtonType.text:
        return TextButton(
          onPressed: isLoading ? null : onPressed,
          child: isLoading ? const CcLoaderWidget() : _buildButtonContent(),
        );
    }
  }

  Widget _buildButtonContent() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (prefixIcon != null) ...[
          Icon(prefixIcon!.icon, size: 14.0),
          const SizedBox(width: 8.0),
        ],
        Text(label),
        if (suffixIcon != null) ...[
          const SizedBox(width: 8.0),
          Icon(suffixIcon!.icon, size: 14.0),
        ],
      ],
    );
  }
}

enum ButtonType {
  elevated,
  outlined,
  text,
}
