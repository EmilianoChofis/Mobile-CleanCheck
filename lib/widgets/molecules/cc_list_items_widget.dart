import 'package:flutter/material.dart';
import 'package:mobile_clean_check/core/theme/themes.dart';
import 'package:mobile_clean_check/widgets/widgets.dart';

class CcListItemsWidget extends StatelessWidget {
  final String title;
  final List<Map<String, String>> content;

  const CcListItemsWidget({
    required this.title,
    required this.content,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextThemes.lightTextTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8.0),
        ...content.map((item) {
          return Column(
            children: [
              CcItemListWidget(
                onTap: () {},
                icon: Icons.domain_outlined,
                title: item['name']!,
                subtitle: item['rooms']!,
              ),
              const SizedBox(height: 12.0),
            ],
          );
        }),
      ],
    );
  }
}
