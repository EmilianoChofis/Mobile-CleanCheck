import 'package:flutter/material.dart';
import 'package:mobile_clean_check/core/theme/themes.dart';

class CcTextFormFieldPasswordWidget extends StatefulWidget {
  final TextEditingController controller;
  final String label;
  final String hint;
  final String? tooltip;
  final String? Function(String?)? validator;

  const CcTextFormFieldPasswordWidget({
    required this.controller,
    required this.label,
    required this.hint,
    this.tooltip,
    this.validator,
    super.key,
  });

  @override
  State<CcTextFormFieldPasswordWidget> createState() =>
      _CcTextFormFieldPasswordWidgetState();
}

class _CcTextFormFieldPasswordWidgetState
    extends State<CcTextFormFieldPasswordWidget> {
  bool _isObscure = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              widget.label,
              style: TextThemes.lightTextTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.w500,
              ),
            ),
            if (widget.tooltip != null)
              Tooltip(
                message: widget.tooltip!,
                child: const Padding(
                  padding: EdgeInsets.only(left: 4.0),
                  child: Icon(
                    Icons.help,
                    size: 16.0,
                    color: ColorSchemes.secondary,
                  ),
                ),
              ),
          ],
        ),
        const SizedBox(height: 8.0),
        TextFormField(
          controller: widget.controller,
          keyboardType: TextInputType.visiblePassword,
          obscureText: _isObscure,
          decoration: InputDecoration(
            prefixIcon: const Icon(Icons.lock_outline),
            suffixIcon: IconButton(
              onPressed: () => setState(() => _isObscure = !_isObscure),
              icon: Icon(
                _isObscure
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
