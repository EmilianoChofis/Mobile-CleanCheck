import 'package:flutter/material.dart';
import 'package:mobile_clean_check/core/theme/themes.dart';

class CcFiltersWidget extends StatefulWidget {
  final List<String> filters;
  final ValueChanged<String> onSelected;

  const CcFiltersWidget({
    required this.filters,
    required this.onSelected,
    super.key,
  });

  @override
  State<CcFiltersWidget> createState() => _CcFiltersWidgetState();
}

class _CcFiltersWidgetState extends State<CcFiltersWidget> {
  final primaryColor = ColorSchemes.primary;
  final secondaryColor = ColorSchemes.secondary;
  final grayColor = ColorSchemes.disabled;

  late String selectedFilter;

  @override
  void initState() {
    super.initState();
    selectedFilter = widget.filters.first;
  }

  Widget _buildFilterChip(String filter) {
    final bool isSelected = filter == selectedFilter;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: ChoiceChip(
        label: Text(filter, style: TextStyle(color: primaryColor)),
        selected: isSelected,
        selectedColor: grayColor,
        checkmarkColor: primaryColor,
        side: BorderSide(color: secondaryColor),
        labelStyle: TextStyle(fontWeight: isSelected ? FontWeight.bold : null),
        visualDensity: VisualDensity.compact,
        onSelected: (selected) => _onChipSelected(filter, isSelected),
      ),
    );
  }

  void _onChipSelected(String filter, bool isSelected) {
    if (!isSelected) {
      setState(() => selectedFilter = filter);
      widget.onSelected(filter);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: Row(
          children:
              widget.filters.map((filter) => _buildFilterChip(filter)).toList()
        ),
      ),
    );
  }
}
