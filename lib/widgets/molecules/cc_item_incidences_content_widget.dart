import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CcItemIncidencesContentWidget extends StatelessWidget {
  final String status;
  final String buildingName;
  final String? personal;
  final bool isDetail;
  final String date;

  const CcItemIncidencesContentWidget({
    required this.status,
    required this.buildingName,
    this.personal,
    this.isDetail = false,
    required this.date,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final secondaryColor = Theme.of(context).colorScheme.secondary;
    late final String formattedDate;

    try {
      final dateTime = DateTime.parse(date);
      formattedDate = DateFormat('dd-MM-yyyy').format(dateTime);
    } catch (e) {
      formattedDate = 'Invalid date';
    }

    return isDetail
        ? _buildDetailContent(secondaryColor, formattedDate)
        : _buildListContent(secondaryColor, formattedDate);
  }

  Widget _buildListContent(Color secondaryColor, String formattedDate) {
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
        Text('Fecha de reporte: $formattedDate',
            style: TextStyle(color: secondaryColor)),
      ],
    );
  }

  Widget _buildDetailContent(Color secondaryColor, String formattedDate) {
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
          'Fecha de reporte: $formattedDate',
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
