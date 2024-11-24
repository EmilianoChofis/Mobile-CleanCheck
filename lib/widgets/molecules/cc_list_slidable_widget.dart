import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:mobile_clean_check/core/theme/themes.dart';

class CcListSlidableWidget<T> extends StatelessWidget {
  final List<T> items;
  final Function(BuildContext, {T? item}) onEdit;
  final Function(BuildContext, {T? item}) onDelete;
  final Widget Function(BuildContext, T item) buildItem;

  const CcListSlidableWidget({
    required this.items,
    required this.onEdit,
    required this.onDelete,
    required this.buildItem,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        return Column(
          children: [
            Slidable(
              key: Key(item.toString()),
              endActionPane: ActionPane(
                motion: const ScrollMotion(),
                children: [
                  SlidableAction(
                    onPressed: (_) => onEdit(context, item: item),
                    icon: Icons.edit_outlined,
                    backgroundColor: ColorSchemes.primary,
                    foregroundColor: ColorSchemes.white,
                    label: 'Editar',
                  ),
                  SlidableAction(
                    onPressed: (_) => onDelete(context, item: item),
                    icon: Icons.delete_outline,
                    backgroundColor: ColorSchemes.error,
                    foregroundColor: ColorSchemes.white,
                    label: 'Eliminar',
                  ),
                ],
              ),
              child: buildItem(context, item),
            ),
            const SizedBox(height: 16.0),
          ],
        );
      },
    );
  }


}
