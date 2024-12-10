import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:mobile_clean_check/core/theme/themes.dart';

class CcCleanRoomsSlidableWidget<T> extends StatelessWidget {
  final List<T> items;
  final Function(BuildContext, {T? item}) onClean;
  final Widget Function(BuildContext, T item) buildItem;

  const CcCleanRoomsSlidableWidget({
    required this.items,
    required this.onClean,
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
                    onPressed: (_) => onClean(context, item: item),
                    icon: Icons.check_circle_outline,
                    backgroundColor: ColorSchemes.success,
                    foregroundColor: ColorSchemes.white,
                    label: 'Marcar como limpia',
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