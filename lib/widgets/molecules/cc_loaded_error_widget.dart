import 'package:flutter/material.dart';
import 'package:mobile_clean_check/widgets/widgets.dart';
import 'package:mobile_clean_check/core/theme/themes.dart';

class CcLoadedErrorWidget extends StatelessWidget {
  final String title;
  final VoidCallback onRetry;

  const CcLoadedErrorWidget({
    required this.title,
    required this.onRetry,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.sentiment_dissatisfied_rounded,
              color: ColorSchemes.primary,
              size: 50,
            ),
            const SizedBox(height: 8.0),
            Text(title),
            const SizedBox(height: 8.0),
            CcButtonWidget(
              label: "Reintentar",
              onPressed: onRetry,
              buttonType: ButtonType.outlined,
              isLoading: false,
            )
          ],
        ),
      ),
    );
  }
}
