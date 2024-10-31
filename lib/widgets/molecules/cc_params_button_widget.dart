import 'package:flutter/material.dart';

class CcParamsButtonWidget extends StatelessWidget {
  final String label;
  final Icon? suffixIcon;
  final Icon? prefixIcon;
  final void Function()? onPressed;
  final ButtonType buttonType;

  const CcParamsButtonWidget({
    required this.label,
    this.suffixIcon,
    this.prefixIcon,
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
          onPressed: onPressed,
          child: _buildButtonContent(),
        );
      case ButtonType.outlined:
        return OutlinedButton(
          onPressed: onPressed,
          child: _buildButtonContent(),
        );
      case ButtonType.text:
        return TextButton(
          onPressed: onPressed,
          child: _buildButtonContent(),
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
