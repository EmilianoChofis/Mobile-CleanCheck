import 'package:flutter/material.dart';
import 'package:mobile_clean_check/core/theme/themes.dart';

class CcItemIncidencesContentWidget extends StatelessWidget {
  final String status;
  final String buildingName;
  final String? personal;
  final bool? isDetail;
  final String date;

  const CcItemIncidencesContentWidget({
    required this.status,
    required this.buildingName,
    this.personal,
    this.isDetail = false,
    required this.date,
    super.key,
  });

  final secondaryColor = ColorSchemes.secondary;

  @override
  Widget build(BuildContext context) {
    return !isDetail! ? _buildListContent() : _buildDetailContent();
  }

  _buildListContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              status,
              style: TextStyle(
                color: secondaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(' | ', style: TextStyle(color: secondaryColor)),
            Expanded(
              child: Text(
                buildingName,
                style: TextStyle(color: secondaryColor),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        Text('Fecha de reporte $date', style: TextStyle(color: secondaryColor)),
      ],
    );
  }

  Widget _buildDetailContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              status,
              style: TextStyle(
                color: secondaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(' | ', style: TextStyle(color: secondaryColor)),
            Expanded(
              child: Text(
                buildingName,
                style: TextStyle(color: secondaryColor),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        Text(
          'Fecha de reporte: $date',
          style: TextStyle(color: secondaryColor),
        ),
        Text(
          'Personal: $personal',
          style: TextStyle(color: secondaryColor),
        ),
      ],
    );
  }
}
