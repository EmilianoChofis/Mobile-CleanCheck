import 'package:flutter/material.dart';
import 'package:mobile_clean_check/widgets/widgets.dart';

class CcReportFormWidget extends StatefulWidget {
  final String room;
  final GlobalKey<FormState> formKey;
  final TextEditingController descriptionController;
  final ValueChanged<bool> onImagesChanged;
  final List<String> base64Images;
  final ValueChanged<List<String>> onImagesUpdated;

  const CcReportFormWidget({
    required this.room,
    required this.formKey,
    required this.descriptionController,
    required this.onImagesChanged,
    required this.base64Images,
    required this.onImagesUpdated,
    super.key,
  });

  @override
  State<CcReportFormWidget> createState() => _CcReportFormWidgetState();
}

class _CcReportFormWidgetState extends State<CcReportFormWidget> {
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

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: widget.formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
              controller: widget.descriptionController,
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
              icon: Icons.camera_alt_outlined,
              onImagesChanged: widget.onImagesChanged,
              base64Images: widget.base64Images,
              onImagesUpdated: widget.onImagesUpdated,
            ),
          ],
        ),
      ),
    );
  }
}
