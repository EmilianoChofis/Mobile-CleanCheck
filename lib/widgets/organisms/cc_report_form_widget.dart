import 'package:flutter/material.dart';
import 'package:mobile_clean_check/widgets/widgets.dart';

class CcReportFormWidget extends StatefulWidget {
  final String room;
  final VoidCallback onClosePreviousBottomSheet;

  const CcReportFormWidget({
    required this.room,
    required this.onClosePreviousBottomSheet,
    super.key,
  });

  @override
  State<CcReportFormWidget> createState() => _CcReportFormWidgetState();
}

class _CcReportFormWidgetState extends State<CcReportFormWidget> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _descriptionController = TextEditingController();
  bool _hasImages = false;

  void _updateImageStatus(bool hasImages) {
    setState(() => _hasImages = hasImages);
  }

  Widget _buildForm() {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            _buildSubtitle(),
            const SizedBox(height: 16.0),
            CcTextFormFieldWidget(
              label: "Descripción del problema",
              hint:
                  "Proporciona información detallada, incluyendo cualquier daño o situación que deba atenderse.",
              icon: const Icon(Icons.warning_amber),
              keyboardType: TextInputType.multiline,
              maxLines: 3,
              controller: _descriptionController,
              validator: (value) {
                if (value!.isEmpty) {
                  return "Ingresa una descripción del problema.";
                }
                return null;
              },
            ),
            const SizedBox(height: 32.0),
            CcImagePickerWidget(
              label: "Adjuntar evidencias",
              hint: "Tomar foto...",
              icon: const Icon(Icons.camera_alt_outlined),
              onImagesChanged: _updateImageStatus,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSubtitle() {
    return Text.rich(
      TextSpan(
        children: [
          const TextSpan(
            text:
                "Describe y adjunta fotos de evidencia que ayuden a detallar el problema de la habitación ",
          ),
          TextSpan(
            text: widget.room,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const TextSpan(text: "."),
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
              content: _buildForm(),
              actions: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  CcButtonWidget(
                    buttonType: ButtonType.elevated,
                    onPressed: _onSave,
                    label: "Enviar reporte",
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
    if (_formKey.currentState!.validate() && _hasImages) {
      widget.onClosePreviousBottomSheet();
      Navigator.pop(context);
    } else {
      if (!_hasImages) {
        CcSnackBarWidget.show(
          context,
          message: "Adjunta al menos 1 foto de evidencia.",
          snackBarType: SnackBarType.error,
        );
      }
    }
  }

  void _onCancel() {
    widget.onClosePreviousBottomSheet();
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return CcButtonWidget(
      buttonType: ButtonType.elevated,
      label: 'Generar reporte',
      isLoading: false,
      onPressed: () => _showBottomSheet(context),
    );
  }
}
