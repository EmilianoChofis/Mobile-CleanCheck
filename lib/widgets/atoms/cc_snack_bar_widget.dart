import 'package:flutter/material.dart';

class CcSnackBarWidget extends StatelessWidget {
  final String message;
  final SnackBarType snackBarType;

  const CcSnackBarWidget({
    required this.message,
    required this.snackBarType,
    super.key,
  });

  Color _getSnackBarColor() {
    switch (snackBarType) {
      case SnackBarType.error:
        return Colors.red;
      case SnackBarType.success:
        return Colors.green;
      case SnackBarType.warning:
        return Colors.orange;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SnackBar(
      content: Text(message),
      behavior: SnackBarBehavior.floating,
      backgroundColor: _getSnackBarColor(),
    );
  }
}

enum SnackBarType { error, success, warning }
