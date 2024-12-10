import 'package:flutter/material.dart';
import 'package:mobile_clean_check/data/models/models.dart';
import 'package:mobile_clean_check/modules/modules.dart';
import 'package:mobile_clean_check/widgets/widgets.dart';

class CcListIncidencesWidget extends StatelessWidget {
  final List<ReportModel> reports;

  const CcListIncidencesWidget({
    required this.reports,
    super.key,
  });

  IconType parseIconType(String? status) {
    switch (status) {
      case 'PENDING':
        return IconType.reported;
      case 'CHECKED':
        return IconType.enabled;
      case 'DISABLED':
        return IconType.disabled;
      default:
        return IconType.displayed;
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
      children: reports.map((item) {
        final iconType = parseIconType(item.status);

        return Column(
          children: [
            CcItemListWidget(
              iconType: iconType,
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => IncidenceDetailScreen(report: item),
                  ),
                );
              },
              icon: Icons.bed_outlined,
              title: 'Habitación ${item.room?.name ?? 'N/A'}',
              content: CcItemIncidencesContentWidget(
                status: interpretStatus(iconType),
                buildingName: 'N/A',
                personal: item.user?.name ?? 'N/A',
                date: item.createdAt ?? 'N/A',
              ),
            ),
            const SizedBox(height: 16.0),
          ],
        );
      }).toList(),
    );
  }
}
