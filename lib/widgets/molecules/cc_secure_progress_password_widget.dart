import 'package:flutter/material.dart';
import 'package:mobile_clean_check/core/theme/themes.dart';

class CcSecureProgressPasswordWidget extends StatefulWidget {
  final String password;

  const CcSecureProgressPasswordWidget({required this.password, super.key});

  @override
  State<CcSecureProgressPasswordWidget> createState() =>
      _CcSecureProgressPasswordWidgetState();
}

class _CcSecureProgressPasswordWidgetState
    extends State<CcSecureProgressPasswordWidget> {

  double _getPasswordStrength(String password) {
    int strength = 0;

    if (password.length >= 8) strength++;
    if (password.contains(RegExp(r'[A-Z]'))) strength++;
    if (password.contains(RegExp(r'[a-z]'))) strength++;
    if (password.contains(RegExp(r'[0-9]'))) strength++;
    if (password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) strength++;

    return strength / 5;
  }

  Color _getStrengthColor(double strength) {
    if (strength <= 0.4) {
      return ColorSchemes.error;
    } else if (strength <= 0.7) {
      return ColorSchemes.warning;
    } else {
      return ColorSchemes.success;
    }
  }

  String _getStrengthText(double strength) {
    if (strength <= 0.4) {
      return "Contraseña débil";
    } else if (strength <= 0.7) {
      return "Contraseña media";
    } else {
      return "Contraseña fuerte";
    }
  }

  @override
  Widget build(BuildContext context) {
    double strength = _getPasswordStrength(widget.password);
    Color strengthColor = _getStrengthColor(strength);
    String strengthText = _getStrengthText(strength);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 8.0),
        LinearProgressIndicator(
          value: strength,
          backgroundColor: ColorSchemes.disabled,
          valueColor: AlwaysStoppedAnimation<Color>(strengthColor),
        ),
        const SizedBox(height: 8.0),
        Text(
          strengthText,
          style: TextThemes.lightTextTheme.bodyLarge?.copyWith(
            fontWeight: FontWeight.w500,
            color: strengthColor,
          ),
        ),
      ],
    );
  }
}
