import 'package:flutter/material.dart';
import 'package:mobile_clean_check/core/theme/themes.dart';

class CcDropDownWidget extends StatefulWidget {
  final List<DropdownMenuItem<String>> items;
  final TextEditingController controller;
  final String? label;
  final String hint;
  final Icon icon;
  final ValueChanged<String?>? onChanged;
  final String? Function(String?)? validator;

  const CcDropDownWidget({
    required this.items,
    required this.controller,
    this.label,
    required this.hint,
    required this.icon,
    this.onChanged,
    this.validator,
    super.key,
  });

  @override
  State<CcDropDownWidget> createState() => _CcDropDownWidgetState();
}

class _CcDropDownWidgetState extends State<CcDropDownWidget> {
  final primaryColor = ColorSchemes.primary;
  final secondaryColor = ColorSchemes.secondary;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label != null)
          Text(
            widget.label!,
            style: TextThemes.lightTextTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),
        const SizedBox(height: 8.0),
        DropdownButtonFormField<String>(
          hint: Text(widget.hint, style: TextStyle(color: secondaryColor)),
          icon: Icon(Icons.keyboard_arrow_down_outlined, color: secondaryColor),
          style: TextStyle(
            color: primaryColor,
            decorationColor: secondaryColor,
            fontSize: 16.0,
            fontFamily: 'Jost',
            fontWeight: FontWeight.w400,
          ),
          decoration: InputDecoration(
            border: OutlineInputBorder(
                borderSide: BorderSide(color: secondaryColor)),
          ),
          items: widget.items,
          onChanged: (value) {
            setState(() {
              widget.controller.text = value ?? '';
            });
            if (widget.onChanged != null) {
              widget.onChanged!(value);
            }
          },
          validator: widget.validator,
        ),
      ],
    );
  }
}
