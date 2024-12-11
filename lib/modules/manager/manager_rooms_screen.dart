import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
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
  final ValueNotifier<Map<String, String>?> selectedRoomNotifier =
      ValueNotifier<Map<String, String>?>(null);
  List<RoomModel> rooms = [];

  @override
  void initState() {
    super.initState();
    _fetchRoomsByBuildingId();
  }

  Future<void> _fetchRoomsByBuildingId() async {
    final buildingId = widget.building.id!;
    context.read<RoomCubit>().getRoomsByBuildingId(buildingId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CcAppBarWidget(title: widget.building.name),
      floatingActionButton: CcFabWidget(
        onPressed: () =>
            _showBuildingBottomSheet(context, widget.building, null),
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
              return const CcLoadingWidget();
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

  void _showBuildingBottomSheet(
    BuildContext context,
    BuildingModel? building,
    RoomModel? room,
  ) {
    CcRoomBottomSheetWidget.show(
      context,
      building: widget.building,
      room: room,
    );
  }

  Widget _buildList(List<RoomModel> rooms) {
    return CcListScreenTemplate(
      title: 'Habitaciones',
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
        filters: const [
          'Todas',
          'En uso',
          'Disponibles',
          'Desocupadas',
          'Reportadas',
          'Limpias'
        ],
        onSelected: (filter) => _onFilterSelected(filter),
      ),
    );
  }

  Widget _buildSymbology() {
    return const CcSymbologyWidget(
      grayLabel: 'En uso',
      whiteLabel: 'Disponible',
      greenLabel: 'Limpia',
      secondaryLabel: 'Desocupada',
      yellowLabel: 'Reportada',
    );
  }

  void _onFilterSelected(String filter) {
    switch (filter) {
      case 'Todas':
        context.read<RoomCubit>().getRoomsByBuildingId(widget.building.id!);
        break;
      case 'En uso':
        //context.read<RoomCubit>().getOccupiedRoomsByBuildingId(widget.building.id!);
        break;
      case 'Disponibles':
        //context.read<RoomCubit>().getAvailableRoomsByBuildingId(widget.building.id!);
        break;
      case 'Desocupadas':
        //context.read<RoomCubit>().getUnoccupiedRoomsByBuildingId(widget.building.id!);
        break;
      case 'Reportadas':
        //context.read<RoomCubit>().getReportedRoomsByBuildingId(widget.building.id!);
        break;
      case 'Limpias':
        //context.read<RoomCubit>().getCleanRoomsByBuildingId(widget.building.id!);
        break;
    }
  }

  Widget _buildContent(List<RoomModel> rooms) {
    final Map<String, List<RoomModel>> floorsWithRooms = {};

    for (var room in rooms) {
      if (room.floor != null) {
        if (!floorsWithRooms.containsKey(room.floor!.name)) {
          floorsWithRooms[room.floor!.name] = [];
        }
        floorsWithRooms[room.floor!.name]!.add(room);
      }
    }

    return RefreshIndicator(
      onRefresh: _fetchRoomsByBuildingId,
      child: rooms.isEmpty
          ? const CcLoadedErrorWidget(
              title: 'No hay pisos con habitaciones registradas',
            )
          : CustomScrollView(
              slivers: [
                for (var floorName in floorsWithRooms.keys) ...[
                  SliverStickyHeader(
                    header: Container(
                      color: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: Text(
                        floorName,
                        style: const TextStyle(
                          color: ColorSchemes.secondary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    sliver: SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          final floorRooms = floorsWithRooms[floorName]!;
                          final Set<String> uniqueRooms = {};

                          return Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children: floorRooms
                                .where((room) => uniqueRooms.add(room.name))
                                .map((room) {
                              final roomId = room.identifier;
                              final roomName = room.name;
                              final roomState = RoomStatus.values.firstWhere(
                                (e) =>
                                    e.toString() ==
                                    'RoomStatus.${room.status?.toLowerCase()}',
                                orElse: () => RoomStatus.unoccupied,
                              );

                              return ValueListenableBuilder<
                                  Map<String, String>?>(
                                valueListenable: selectedRoomNotifier,
                                builder: (context, selectedRoom, _) {
                                  return CcRoomWidget(
                                    name: roomName,
                                    state: roomState,
                                    isSelected: selectedRoom != null &&
                                        selectedRoom['identifier'] == roomId,
                                  );
                                },
                              );
                            }).toList(),
                          );
                        },
                        childCount: 1,
                      ),
                    ),
                  ),
                ],
              ],
            ),
    );
  }
}
