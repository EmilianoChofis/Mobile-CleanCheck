import 'package:flutter/material.dart';
import 'package:mobile_clean_check/modules/modules.dart';
import 'package:mobile_clean_check/widgets/widgets.dart';

class CcListIncidencesWidget extends StatelessWidget {
  final List<Map<String, String>> content;

  const CcListIncidencesWidget({
    required this.content,
    super.key,
  });

  IconType parseIconType(String status) {
    switch (status) {
      case 'IconType.disabled':
        return IconType.disabled;
      case 'IconType.reported':
        return IconType.reported;
      case 'IconType.enabled':
        return IconType.enabled;
      default:
        throw ArgumentError('Invalid IconType: $status');
    }
  }

  String interpretStatus(IconType iconType) {
    switch (iconType) {
      case IconType.displayed:
        return '';
      case IconType.enabled:
        return 'Disponible';
      case IconType.reported:
        return 'En proceso';
      case IconType.disabled:
        return 'Deshabilitada';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: content.map((item) {
        final iconType = parseIconType(item['status']!);

        return Column(
          children: [
            CcItemListWidget(
              iconType: parseIconType(item['status']!),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => IncidenceDetailScreen(room: item),
                  ),
                );
              },
              icon: Icons.bed_outlined,
              title: 'Habitación ${item['room']!}',
              content: CcItemIncidencesContentWidget(
                status: interpretStatus(iconType),
                buildingName: item['building']!,
                personal: item['personal']!,
                date: item['date']!,
              ),
            ),
            const SizedBox(height: 16.0),
          ],
        );
      }).toList(),
    );
  }
}
