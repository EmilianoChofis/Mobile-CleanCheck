import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_clean_check/core/theme/themes.dart';
import 'package:mobile_clean_check/data/cubits/cubits.dart';
import 'package:mobile_clean_check/data/models/models.dart';
import 'package:mobile_clean_check/widgets/widgets.dart';

class ManagerRoomsScreen extends StatefulWidget {
  final BuildingModel building;
  const ManagerRoomsScreen({required this.building, super.key});

  @override
  State<ManagerRoomsScreen> createState() => _ManagerRoomsScreenState();
}

class _ManagerRoomsScreenState extends State<ManagerRoomsScreen> {
  final _searchController = SearchController();

  @override
  void initState() {
    super.initState();
    context.read<FloorCubit>().getFloorsByBuildingId(widget.building.id!);
    context.read<RoomCubit>().getRooms(widget.building);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CcAppBarWidget(title: widget.building.name),
      floatingActionButton: CcFabWidget(
        onPressed: () => _showBuildingBottomSheet(context),
        icon: Icons.add,
      ),
      body: BlocListener<RoomCubit, RoomState>(
        listener: (context, state) {
          if (state is RoomError) {
            CcSnackBarWidget.show(
              context,
              message: state.message,
              snackBarType: SnackBarType.error,
            );
          } else if (state is RoomSuccess) {
            CcSnackBarWidget.show(
              context,
              message: state.message,
              snackBarType: SnackBarType.success,
            );

            if (Navigator.canPop(context)) {
              Navigator.pop(context);
            }
          }
        },
        child: BlocBuilder<RoomCubit, RoomState>(
          builder: (context, state) {
            if (state is RoomLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is RoomLoaded) {
              return _buildList(state.rooms);
            } else {
              return _buildList([]);
            }
          },
        ),
      ),
    );
  }

  Widget _buildList(List<RoomModel> rooms) {
    return CcListScreenTemplate(
      title: 'Lista de habitaciones',
      search: CcSearchBarWidget(controller: _searchController),
      filters: _buildFilters(),
      symbology: _buildSymbology(),
      content: _buildContent(rooms),
    );
  }

  Widget _buildFilters() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: CcFiltersWidget(
        filters: const ['Todas', 'Disponibles', 'Reportadas', 'Deshabilitadas'],
        onSelected: (filter) => _onFilterSelected(filter),
      ),
    );
  }

  void _onFilterSelected(String filter) {
    print('Filtro seleccionado: $filter');
  }

  Widget _buildSymbology() {
    return const CcSymbologyWidget(
      grayLabel: 'Disponible',
      yellowLabel: 'Reportada',
      redLabel: 'Deshabilitada',
    );
  }

  Widget _buildContent(List<RoomModel> rooms) {
    if (rooms.isEmpty) {
      return const Center(child: Text('No hay habitaciones registrados.'));
    }

    Map<String, List<RoomModel>> groupedRooms = {};
    for (var room in rooms) {
      final floorName = room.identifier;
      if (groupedRooms.containsKey(floorName)) {
        groupedRooms[floorName]!.add(room);
      } else {
        groupedRooms[floorName] = [room];
      }
    }

    var sortedFloorNames = groupedRooms.keys.toList();

    return ListView.builder(
      itemCount: sortedFloorNames.length,
      itemBuilder: (context, index) {
        final floorName = sortedFloorNames[index];
        final floorRooms = groupedRooms[floorName]!;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                floorName,
                style: const TextStyle(
                  color: ColorSchemes.secondary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 8.0),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: floorRooms.length,
              itemBuilder: (context, roomIndex) {
                final room = floorRooms[roomIndex];

                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: CcItemListWidget(
                    iconType: IconType.enabled,
                    onTap: () {},
                    icon: Icons.domain_outlined,
                    title: room.name,
                    content: Text(
                      room.status!,
                      style: const TextStyle(color: ColorSchemes.secondary),
                    ),
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }

  void _showBuildingBottomSheet(BuildContext context, {RoomModel? room}) {
    CcRoomBottomSheetWidget.show(context, room: room);
  }
}
