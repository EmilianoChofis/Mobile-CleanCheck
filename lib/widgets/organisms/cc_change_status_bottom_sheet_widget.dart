import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_clean_check/data/cubits/cubits.dart';
import 'package:mobile_clean_check/data/models/models.dart';
import 'package:mobile_clean_check/widgets/widgets.dart';

class CcChangeStatusBottomSheetWidget {
  static void show(
    BuildContext context, {
    required BuildingModel building,
    required String title,
    required String cardTitle,
    required String cardSubtitle,
    required IconType cardType,
    required IconData cardIcon,
    required Widget content,
  }) {
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
              title: title,
              content: _buildContent(
                context,
                cardTitle,
                cardSubtitle,
                cardType,
                cardIcon,
              ),
              actions: _buildActions(context, title, building.id!),
            );
          },
        );
      },
    );
  }

  static Widget _buildContent(
    BuildContext context,
    String cardTitle,
    String cardSubtitle,
    IconType cardType,
    IconData cardIcon,
  ) {
    return CcItemListWidget(
      isDisplay: true,
      title: cardTitle,
      content: Text('$cardSubtitle pisos'),
      iconType: cardType,
      icon: cardIcon,
      onTap: () {},
    );
  }

  static Widget _buildActions(BuildContext context, String title, String id) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        CcButtonWidget(
          buttonType: ButtonType.elevated,
          onPressed: () => _onSave(context, id),
          label: title,
          isLoading: false,
        ),
        const SizedBox(height: 8.0),
        CcButtonWidget(
          buttonType: ButtonType.outlined,
          onPressed: () => Navigator.of(context).pop(),
          label: 'Cancelar',
          isLoading: false,
        ),
      ],
    );
  }

  static void _onSave(BuildContext context, String buildingId) {
    context.read<BuildingCubit>().deleteBuilding(buildingId);
    Navigator.of(context).pop();
  }
}
