import 'package:flutter/material.dart';
import 'package:mobile_clean_check/core/theme/themes.dart';
import 'package:mobile_clean_check/widgets/widgets.dart';

class CcListItemsWidget extends StatelessWidget {
  final List<Map<String, dynamic>> items;
  final Function(Map<String, dynamic>) onTap;

  const CcListItemsWidget({
    required this.items,
    required this.onTap,
    super.key,
  });

  final secondaryColor = ColorSchemes.secondary;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: items.map((item) {
        return Column(
          children: [
            CcItemListWidget(
              iconType: IconType.enabled,
              onTap: () => onTap(item),
              icon: Icons.domain_outlined,
              title: item['name']!,
              content: Text(
                item['rooms']!,
                style: TextStyle(color: secondaryColor),
              ),
            ),
            const SizedBox(height: 16.0),
          ],
        );
      }).toList(),
    );
  }
}
