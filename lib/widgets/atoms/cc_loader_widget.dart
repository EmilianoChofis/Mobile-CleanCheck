import 'package:flutter/material.dart';
import 'package:mobile_clean_check/core/theme/color_schemes.dart';

class CcLoaderWidget extends StatelessWidget {
  const CcLoaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: SizedBox(
        height: 15.0,
        width: 15.0,
        child: Center(
          child: CircularProgressIndicator(
            strokeWidth: 3,
            color: ColorSchemes.white,
          ),
        ),
      ),
    );
  }
}
