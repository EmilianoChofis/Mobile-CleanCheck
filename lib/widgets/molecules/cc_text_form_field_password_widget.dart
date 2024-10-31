import 'package:flutter/material.dart';
import 'package:mobile_clean_check/core/theme/text_themes.dart';

class CcTextFormFieldPasswordWidget extends StatefulWidget {
  final TextEditingController controller;
  final String label;
  final String hint;
  final String? Function(String?)? validator;

  const CcTextFormFieldPasswordWidget({
    required this.controller,
    required this.label,
    required this.hint,
    this.validator,
    super.key,
  });

  @override
  State<CcTextFormFieldPasswordWidget> createState() =>
      _CcTextFormFieldPasswordWidgetState();
}

class _CcTextFormFieldPasswordWidgetState
    extends State<CcTextFormFieldPasswordWidget> {
  bool _isOscure = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: TextThemes.lightTextTheme.bodyLarge?.copyWith(
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8.0),
        TextFormField(
          controller: widget.controller,
          keyboardType: TextInputType.visiblePassword,
          obscureText: _isOscure,
          decoration: InputDecoration(
            prefixIcon: const Icon(Icons.lock_outline),
            suffixIcon: IconButton(
              onPressed: () => setState(() => _isOscure = !_isOscure),
              icon: Icon(
                _isOscure
                    ? Icons.visibility_off_outlined
                    : Icons.visibility_outlined,
              ),
            ),
            hintText: widget.hint,
          ),
          validator: widget.validator,
        ),
      ],
    );
  }
}
