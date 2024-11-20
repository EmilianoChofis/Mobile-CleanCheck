import 'package:flutter/material.dart';
import 'package:mobile_clean_check/widgets/widgets.dart';
import 'package:mobile_clean_check/core/theme/themes.dart';

class CcReportButtonWidget extends StatefulWidget {
  const CcReportButtonWidget({super.key});

  @override
  State<CcReportButtonWidget> createState() => _CcReportButtonWidgetState();
}

class _CcReportButtonWidgetState extends State<CcReportButtonWidget> {
  final redColor = ColorSchemes.error;
  final secondaryColor = ColorSchemes.secondary;

  Widget _buildText(String text) {
    return Text(
      text,
      style: TextStyle(color: secondaryColor),
    );
  }

  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      isDismissible: false,
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.85,
      ),
      enableDrag: false,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return CcBottomSheetTemplate(
              title: "Reportar incidencia",
              subtitle:
                  "Puedes reportar la habitación si presenta daños o no está en condiciones para ser rentada nuevamente.",
              content: _buildText(
                  "Los detalles de la habitación se enviarán al gerente, y estará como reportada hasta que el gerente brinde una solución."),
              actions: Column(
                children: [
                  CcButtonWidget(
                    buttonType: ButtonType.elevated,
                    onPressed: _onSave,
                    label: "Fijar habitaciones",
                    isLoading: false,
                  ),
                  const SizedBox(height: 8.0),
                  CcButtonWidget(
                    buttonType: ButtonType.outlined,
                    onPressed: _onCancel,
                    label: "Cancelar",
                    isLoading: false,
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  void _onSave() {
    Navigator.pop(context);
  }

  void _onCancel() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return CcButtonWidget(
      buttonType: ButtonType.outlined,
      prefixIcon: const Icon(Icons.warning_amber),
      label: 'Reportar',
      isLoading: false,
      color: redColor,
      onPressed: () => _showBottomSheet(context),
    );
  }
}
