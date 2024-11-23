import 'package:flutter/material.dart';
import 'package:mobile_clean_check/modules/modules.dart';
import 'package:mobile_clean_check/widgets/molecules/cc_item_simple_content_widget.dart';
import 'package:mobile_clean_check/widgets/widgets.dart';

class CcListItemsWidget extends StatelessWidget {
  final List<Map<String, String>> content;

  const CcListItemsWidget({
    required this.content,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: content.map((item) {
        return Column(
          children: [
            CcItemListWidget(
              iconType: IconType.enabled,
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const MaidBuildingScreen(),
                  ),
                );
              },
              icon: Icons.domain_outlined,
              title: item['name']!,
              content: CcItemSimpleContentWidget(subtitle: item['rooms']!),
            ),
            const SizedBox(height: 16.0),
          ],
        );
      }).toList(),
    );
  }
}
