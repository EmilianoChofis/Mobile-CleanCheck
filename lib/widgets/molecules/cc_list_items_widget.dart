import 'package:flutter/material.dart';
import 'package:mobile_clean_check/modules/modules.dart';
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
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const MaidBuildingScreen(),
                  ),
                );
              },
              icon: Icons.domain_outlined,
              title: item['name']!,
              subtitle: CcItemListSimpleContentWidget(subtitle: item['rooms']!),
            ),
            const SizedBox(height: 16.0),
          ],
        );
      }).toList(),
    );
  }
}
