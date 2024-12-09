import 'package:flutter/material.dart';
import 'package:mobile_clean_check/widgets/widgets.dart';

class IncidenceDetailScreen extends StatelessWidget {
  final Map<String, String> room;
  const IncidenceDetailScreen({required this.room, super.key});

  @override
  Widget build(BuildContext context) {
    final iconType = parseIconType(room['status']!);
    return Scaffold(
      appBar: const CcAppBarWidget(title: 'Reporte de incidencia'),
      body: CcHeaderTemplate(
        header: _buildHeader(iconType),
        content: _buildContent(iconType),
      ),
    );
  }

  IconType parseIconType(String status) {
    switch (status) {
      case 'IconType.disabled':
        return IconType.disabled;
      case 'IconType.reported':
        return IconType.reported;
      case 'IconType.enabled':
        return IconType.enabled;
      default:
        throw ArgumentError('Invalid IconType: $status');
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
        iconType: parseIconType(room['status']!),
        onTap: () {},
        icon: Icons.bed_outlined,
        title: 'Habitación ${room['room']!}',
        content: CcItemIncidencesContentWidget(
          status: interpretStatus(iconType),
          buildingName: room['building']!,
          date: room['date']!,
          isDetail: true,
        ),
      ),
    );
  }

  Widget _buildContent(iconType) {
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
              text:
                  'La televisión está rota y el cristal de las ventanas se encuentran estrellados.',
            ),
            readOnly: true,
          ),
          const SizedBox(height: 32.0),
          const CcImagesDisplayWidget(
            title: 'Evidencias adjuntas',
            images: [
              'https://placehold.co/100x130/png',
              'https://placehold.co/100x130/png',
              'https://placehold.co/100x130/png',
              'https://placehold.co/100x130/png',
              'https://placehold.co/100x130/png',
            ],
          ),
        ],
      ),
    );
  }
}
