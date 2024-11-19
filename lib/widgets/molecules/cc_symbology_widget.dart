import 'package:flutter/material.dart';
import 'package:mobile_clean_check/core/theme/themes.dart';

class CcSymbologyWidget extends StatelessWidget {
  final String? grayLabel;
  final String? whiteLabel;
  final String? yellowLabel;
  final String? redLabel;

  const CcSymbologyWidget({
    this.grayLabel,
    this.whiteLabel,
    this.yellowLabel,
    this.redLabel,
    super.key,
  });

  final primaryColor = ColorSchemes.primary;
  final grayColor = ColorSchemes.disabled;
  final whiteColor = ColorSchemes.white;
  final yellowColor = ColorSchemes.warning;
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
        const SizedBox(width: 4),
        _buildText(label),
        const SizedBox(width: 8),
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
          _buildSymbology(yellowLabel, yellowColor),
          _buildSymbology(redLabel, redColor),
        ],
      ),
    );
  }
}
