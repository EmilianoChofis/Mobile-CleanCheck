import 'package:flutter/material.dart';
import 'package:mobile_clean_check/widgets/widgets.dart';
import 'package:mobile_clean_check/core/theme/themes.dart';

class CcButtonWidget extends StatelessWidget {
  final String label;
  final Icon? suffixIcon;
  final Icon? prefixIcon;
  final Color? color;
  final bool isLoading;
  final VoidCallback? onPressed;
  final ButtonType buttonType;

  const CcButtonWidget({
    required this.label,
    this.suffixIcon,
    this.prefixIcon,
    this.color = ColorSchemes.primary,
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
          style: ElevatedButton.styleFrom(backgroundColor: color),
          child: isLoading ? const CcLoaderWidget() : _buildButtonContent(),
        );
      case ButtonType.outlined:
        return OutlinedButton(
          onPressed: isLoading ? null : onPressed,
          style: ElevatedButton.styleFrom(
            foregroundColor: color,
            side: BorderSide(color: color!),
          ),
          child: isLoading ? const CcLoaderWidget() : _buildButtonContent(),
        );
      case ButtonType.text:
        return TextButton(
          onPressed: isLoading ? null : onPressed,
          style: TextButton.styleFrom(foregroundColor: color),
          child: isLoading ? const CcLoaderWidget() : _buildButtonContent(),
        );
    }
  }

  Widget _buildButtonContent() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (prefixIcon != null) ...[
          Icon(prefixIcon!.icon, size: 14.0),
          const SizedBox(width: 8.0),
        ],
        Flexible(
          child: Text(label, overflow: TextOverflow.ellipsis, maxLines: 1),
        ),
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
