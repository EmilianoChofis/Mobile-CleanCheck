import 'package:flutter/material.dart';
import 'package:mobile_clean_check/widgets/widgets.dart';
import 'package:mobile_clean_check/core/theme/themes.dart';

class CcReportButtonWidget extends StatefulWidget {
  final ValueNotifier<String?> selectedRoomNotifier;

  const CcReportButtonWidget({required this.selectedRoomNotifier, super.key});

  @override
  State<CcReportButtonWidget> createState() => _CcReportButtonWidgetState();
}

class _CcReportButtonWidgetState extends State<CcReportButtonWidget> {
  final redColor = ColorSchemes.error;
  final secondaryColor = ColorSchemes.secondary;

  Widget _buildText() {
    return Text.rich(
      style: TextStyle(color: secondaryColor),
      const TextSpan(
        children: [
          TextSpan(
            text:
                "Los detalles de la habitación se enviarán al gerente, y estará como ",
          ),
          TextSpan(
            text: "reportada",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          TextSpan(
            text: " hasta que el gerente brinde una solución.",
          ),
        ],
      ),
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
              content: _buildText(),
              actions: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  CcReportFormWidget(
                    room: widget.selectedRoomNotifier.value!,
                    onClosePreviousBottomSheet: () => Navigator.pop(context),
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

  void _onCancel() => Navigator.pop(context);

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
