import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_clean_check/data/cubits/cubits.dart';
import 'package:mobile_clean_check/data/models/report_model.dart';
import 'package:mobile_clean_check/widgets/widgets.dart';

class CcGeneratedReportButtonWidget extends StatefulWidget {
  final String userId;
  final String buildingId;
  final Map<String, String> room;
  final VoidCallback? onClosePreviousBottomSheet;

  const CcGeneratedReportButtonWidget({
    required this.userId,
    required this.buildingId,
    required this.room,
    this.onClosePreviousBottomSheet,
    super.key,
  });

  @override
  State<CcGeneratedReportButtonWidget> createState() =>
      _CcGeneratedReportButtonWidgetState();
}

class _CcGeneratedReportButtonWidgetState
    extends State<CcGeneratedReportButtonWidget> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _descriptionController = TextEditingController();
  List<String> _base64Images = [];

  void _updateImageStatus(bool hasImages) {}

  void _onSave() {
    if (_formKey.currentState!.validate() && _base64Images.isNotEmpty) {
      widget.onClosePreviousBottomSheet?.call();

      final reportCubit = context.read<ReportCubit>();
      final RoomCubit roomCubit = context.read<RoomCubit>();

      final newReport = ReportModel(
        userId: widget.userId,
        roomId: widget.room['id']!,
        description: _descriptionController.text,
        files: _base64Images,
      );

      reportCubit.createReport(newReport);
      roomCubit.getRoomsByBuildingId(widget.buildingId);
      Navigator.pop(context);
    } else {
      if (_base64Images.isEmpty) {
        CcSnackBarWidget.show(
          context,
          message: "Adjunta al menos 1 foto de evidencia.",
          snackBarType: SnackBarType.error,
        );
      }
    }
  }

  void _onCancel() {
    widget.onClosePreviousBottomSheet?.call();
    Navigator.pop(context);
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
              content: CcReportFormWidget(
                room: widget.room['identifier']!,
                formKey: _formKey,
                descriptionController: _descriptionController,
                onImagesChanged: _updateImageStatus,
                base64Images: _base64Images,
                onImagesUpdated: (images) => setState(() {
                  _base64Images = images;
                }),
              ),
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
