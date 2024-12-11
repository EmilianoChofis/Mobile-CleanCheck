import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_clean_check/core/theme/themes.dart';
import 'package:mobile_clean_check/data/cubits/cubits.dart';
import 'package:mobile_clean_check/data/models/models.dart';
import 'package:mobile_clean_check/widgets/widgets.dart';

class CcCleanButtonWidget extends StatefulWidget {
  final BuildingModel building;
  final ValueNotifier<Map<String, String>?> selectedRoomNotifier;

  const CcCleanButtonWidget({
    required this.building,
    required this.selectedRoomNotifier,
    super.key,
  });

  @override
  State<CcCleanButtonWidget> createState() => _CcCleanButtonWidgetState();
}

class _CcCleanButtonWidgetState extends State<CcCleanButtonWidget> {
  final primaryColor = ColorSchemes.primary;

  @override
  Widget build(BuildContext context) {
    return CcButtonWidget(
      buttonType: ButtonType.elevated,
      onPressed: () => _showBottomSheet(context),
      label: "Marcar como limpia",
      isLoading: false,
    );
  }

  Widget _buildItemDescription(String room) {
    return Text.rich(
      TextSpan(
        text: "La habitación ",
        children: [
          TextSpan(
            text: room,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const TextSpan(
            text:
                " estará disponible para rentarse nuevamente. ¿Deseas continuar?",
          ),
        ],
      ),
    );
  }

  Widget _buildBuildingItem(String room) {
    return CcItemListWidget(
      iconType: IconType.enabled,
      icon: Icons.apartment,
      title: widget.building.name,
      content: Text.rich(
        style: TextStyle(color: primaryColor),
        TextSpan(
          text: "Habitación ",
          children: [
            TextSpan(
              text: room,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
      onTap: () {},
      isDisplay: true,
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
            final selectedRoom = widget.selectedRoomNotifier.value;
            final roomName = selectedRoom?['identifier'] ?? '';

            return CcBottomSheetTemplate(
              title: "Marcar como limpia",
              content: CcItemStatusContentWidget(
                item: _buildBuildingItem(roomName),
                description: _buildItemDescription(roomName),
              ),
              actions: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  CcButtonWidget(
                    buttonType: ButtonType.elevated,
                    onPressed: _onSave,
                    label: "Marcar como limpia",
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
    final roomId = widget.selectedRoomNotifier.value?['id'];
    context.read<RoomCubit>().changeClean(roomId!);
    context.read<RoomCubit>().getRoomsByBuildingId(widget.building.id!);
  }

  void _onCancel() => Navigator.pop(context);
}
