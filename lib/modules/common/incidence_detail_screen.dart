import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_clean_check/data/cubits/cubits.dart';
import 'package:mobile_clean_check/data/models/models.dart';
import 'package:mobile_clean_check/widgets/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class IncidenceDetailScreen extends StatefulWidget {
  final ReportModel report;

  const IncidenceDetailScreen({required this.report, super.key});

  @override
  State<IncidenceDetailScreen> createState() => _IncidenceDetailScreenState();
}

class _IncidenceDetailScreenState extends State<IncidenceDetailScreen> {
  String _userRole = '';

  @override
  void initState() {
    super.initState();
    _loadUserRole();
  }

  Future<void> _loadUserRole() async {
    final prefs = await SharedPreferences.getInstance();
    final userRole = prefs.getString('role');
    setState(() => _userRole = userRole!);
  }

  @override
  Widget build(BuildContext context) {
    final iconType = parseIconType(widget.report.status);
    return Scaffold(
      appBar: const CcAppBarWidget(title: 'Reporte de incidencia'),
      body: CcHeaderTemplate(
        header: _buildHeader(iconType),
        content: _buildContent(iconType),
      ),
      bottomNavigationBar: _userRole == 'Manager'
          ? BottomAppBar(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    child: CcButtonWidget(
                      label: 'Finalizar reporte',
                      onPressed: () {},
                      isLoading: false,
                      buttonType: widget.report.status == 'PENDING'
                          ? ButtonType.outlined
                          : ButtonType.elevated,
                    ),
                  ),
                  const SizedBox(width: 8.0),
                  if (widget.report.status == 'PENDING')
                    Expanded(
                      child: CcButtonWidget(
                        label: 'Proceder reporte',
                        onPressed: () {
                          _showChangeStatusBottomSheet(context, widget.report);
                        },
                        isLoading: false,
                        buttonType: ButtonType.elevated,
                      ),
                    ),
                ],
              ),
            )
          : null,
    );
  }

  void _showChangeStatusBottomSheet(BuildContext context, ReportModel item) {
    final it = item.status == 'PENDING' ? IconType.reported : IconType.enabled;
    CcChangeStatusBottomSheetWidget.show(
      context,
      item: item,
      title: 'Proceder reporte',
      cardIcon: Icons.bed_outlined,
      cardTitle: 'Habitación ${item.room!.identifier}',
      cardSubtitle: item.room!.floor!.building!.name,
      cardType: it,
      content: const Text(
        '¿Estás seguro de proceder con el reporte?',
      ),
      onConfirm: (id) {
        context.read<ReportCubit>().changeStatusIn(id);
        context.read<ReportCubit>().getReports();
      },
    );
  }

  IconType parseIconType(String? status) {
    switch (status) {
      case 'PENDING':
        return IconType.reported;
      case 'FINISHED':
        return IconType.enabled;
      case 'IN_PROGRESS':
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
        return 'Finalizado';
      case IconType.reported:
        return 'Pendiente';
      case IconType.disabled:
        return 'En progreso';
    }
  }

  Widget _buildStatusDescription(IconType iconType) {
    switch (iconType) {
      case IconType.displayed:
        return const SizedBox.shrink();
      case IconType.enabled:
        return const Text.rich(
          style: TextStyle(fontSize: 16.0),
          TextSpan(
            children: [
              TextSpan(text: 'El gerente marcó la habitación como '),
              TextSpan(
                text: 'disponible',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              TextSpan(
                text: ' para ser rentada nuevamente.',
              ),
            ],
          ),
        );
      case IconType.reported:
        return const Text.rich(
          style: TextStyle(fontSize: 16.0),
          TextSpan(
            children: [
              TextSpan(text: 'La habitación estará marcada como '),
              TextSpan(
                text: 'reportada',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              TextSpan(
                text: ' hasta que el gerente brinde una solución.',
              ),
            ],
          ),
        );
      case IconType.disabled:
        return const Text.rich(
          style: TextStyle(fontSize: 16.0),
          TextSpan(
            children: [
              TextSpan(text: 'El gerente marcó la habitación como '),
              TextSpan(
                text: 'deshabilitada',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              TextSpan(
                text: ' hasta completar las restauraciones necesarias.',
              )
            ],
          ),
        );
    }
  }

  Widget _buildHeader(IconType iconType) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: CcItemListWidget(
        iconType: iconType,
        onTap: () {},
        icon: Icons.bed_outlined,
        title: 'Habitación ${widget.report.room?.identifier}',
        content: CcItemIncidencesContentWidget(
          status: interpretStatus(iconType),
          buildingName: widget.report.room!.floor!.building!.name,
          date: widget.report.createdAt!,
          personal: widget.report.user?.name,
          isDetail: true,
        ),
      ),
    );
  }

  Widget _buildContent(IconType iconType) {
    return CcTitleContentTemplate(
      title: 'Detalle de incidencia',
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 4.0),
            child: _buildStatusDescription(iconType),
          ),
          const SizedBox(height: 32.0),
          CcTextFormFieldWidget(
            label: 'Descripción del problema',
            hint: '',
            icon: const Icon(Icons.warning_amber),
            keyboardType: TextInputType.multiline,
            maxLines: null,
            controller: TextEditingController(
              text: widget.report.description,
            ),
            readOnly: true,
          ),
          const SizedBox(height: 32.0),
          CcImagesDisplayWidget(
            title: 'Evidencias adjuntas',
            images:
                widget.report.images?.map((image) => image.url).toList() ?? [],
          ),
        ],
      ),
    );
  }
}
