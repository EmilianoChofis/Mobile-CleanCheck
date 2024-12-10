import 'package:flutter/material.dart';
import 'package:mobile_clean_check/core/theme/themes.dart';

class CcSymbologyWidget extends StatelessWidget {
  final String? grayLabel;
  final String? whiteLabel;
  final String? secondaryLabel;
  final String? greenLabel;
  final String? yellowLabel;
  final String? redLabel;

  const CcSymbologyWidget({
    this.grayLabel,
    this.whiteLabel,
    this.secondaryLabel,
    this.yellowLabel,
    this.greenLabel,
    this.redLabel,
    super.key,
  });

  final primaryColor = ColorSchemes.primary;
  final secondaryColor = ColorSchemes.secondary;
  final grayColor = ColorSchemes.disabled;
  final whiteColor = ColorSchemes.white;
  final yellowColor = ColorSchemes.warning;
  final greenColor = ColorSchemes.success;
  final redColor = ColorSchemes.error;

  Widget _buildSymbol(String? label, Color color) {
    return Container(
      width: 12,
      height: 12,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(64),
        border: label == whiteLabel ? Border.all(color: primaryColor) : null,
      ),
    );
  }

  Widget _buildText(String? text) {
    return Text(
      text ?? '',
      style: const TextStyle(fontWeight: FontWeight.w500),
    );
  }

  Widget _buildSymbology(String? label, Color color) {
    if (label == null) {
      return Container();
    }

    return Row(
      children: [
        _buildSymbol(label, color),
        const SizedBox(width: 4.0),
        _buildText(label),
        const SizedBox(width: 12.0),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          _buildSymbology(grayLabel, grayColor),
          _buildSymbology(whiteLabel, whiteColor),
          _buildSymbology(secondaryLabel, secondaryColor),
          _buildSymbology(yellowLabel, yellowColor),
          _buildSymbology(greenLabel, greenColor),
          _buildSymbology(redLabel, redColor),
        ],
      ),
    );
  }
}
