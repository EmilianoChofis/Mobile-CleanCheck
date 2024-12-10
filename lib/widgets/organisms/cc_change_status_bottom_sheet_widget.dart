import 'package:flutter/material.dart';
import 'package:mobile_clean_check/widgets/widgets.dart';

class CcChangeStatusBottomSheetWidget {
  static void show(
    BuildContext context, {
    required dynamic item,
    required String title,
    required String cardTitle,
    required String cardSubtitle,
    required IconType cardType,
    required IconData cardIcon,
    required Widget content,
    required void Function(String id) onConfirm,
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
              actions: _buildActions(context, title, item.id!, onConfirm),
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
      content: Text(cardSubtitle),
      iconType: cardType,
      icon: cardIcon,
      onTap: () {},
    );
  }

  static Widget _buildActions(BuildContext context, String title, String id,
      void Function(String id) onConfirm) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        CcButtonWidget(
          buttonType: ButtonType.elevated,
          onPressed: () {
            onConfirm(id);
            if (Navigator.canPop(context)) {
              Navigator.pop(context);
            }
          },
          label: title,
          isLoading: false,
        ),
        const SizedBox(height: 8.0),
        CcButtonWidget(
          buttonType: ButtonType.outlined,
          onPressed: () {
            if (Navigator.canPop(context)) {
              Navigator.pop(context);
            }
          },
          label: 'Cancelar',
          isLoading: false,
        ),
      ],
    );
  }
}
