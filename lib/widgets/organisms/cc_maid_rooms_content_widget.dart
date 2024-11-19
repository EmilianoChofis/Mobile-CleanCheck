import 'package:flutter/material.dart';
import 'package:mobile_clean_check/widgets/widgets.dart';

class CcMaidRoomsContentWidget extends StatelessWidget {
  const CcMaidRoomsContentWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CcFiltersWidget(
          filters: const [
            'Zona de trabajo',
            'Todas',
            'Sin limpiar',
            'Limpias',
            'Reportadas',
            'Deshabilitadas'
          ],
          onSelected: (filter) {
            print(filter);
          },
        ),
        const CcSymbologyWidget(
          grayLabel: 'Limpia',
          whiteLabel: 'Sin limpiar',
          yellowLabel: 'Reportada',
          redLabel: 'Deshabilitada',
        ),
      ],
    );
  }
}
