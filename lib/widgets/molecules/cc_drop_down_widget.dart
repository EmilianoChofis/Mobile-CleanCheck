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
  String? _selectedValue;

  @override
  void initState() {
    super.initState();
    // Ensure _selectedValue is initialized with a valid value from the list
    if (widget.items.isNotEmpty) {
      _selectedValue = widget.items.first.value; // Set it to the first item initially
    }
  }

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
          value: _selectedValue,
          hint: Text(widget.hint,
              style: const TextStyle(color: ColorSchemes.secondary)),
          icon: const Icon(Icons.keyboard_arrow_down_outlined,
              color: ColorSchemes.secondary),
          style: const TextStyle(
            color: ColorSchemes.primary,
            decorationColor: ColorSchemes.secondary,
            fontSize: 16.0,
            fontFamily: 'Jost',
            fontWeight: FontWeight.w400,
          ),
          decoration: const InputDecoration(
            border: OutlineInputBorder(
              borderSide: BorderSide(
                color: ColorSchemes.secondary,
              ),
            ),
          ),
          items: widget.items,
          onChanged: (value) {
            setState(() {
              _selectedValue = value;
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
