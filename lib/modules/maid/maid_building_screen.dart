import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:mobile_clean_check/core/theme/themes.dart';
import 'package:mobile_clean_check/data/cubits/cubits.dart';
import 'package:mobile_clean_check/data/models/models.dart';
import 'package:mobile_clean_check/widgets/widgets.dart';

class MaidBuildingScreen extends StatefulWidget {
  final BuildingModel building;

  const MaidBuildingScreen({required this.building, super.key});

  @override
  State<MaidBuildingScreen> createState() => _MaidBuildingScreenState();
}

class _MaidBuildingScreenState extends State<MaidBuildingScreen> {
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
      appBar: CcAppBarWidget(
        title: 'Registrar limpieza',
        actions: [
          CcPinButtonWidget(
            roomIdentifiers: rooms.map((room) => room.identifier).toList(),
            buildingIdentifier: widget.building.id!,
          ),
        ],
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
        child: BlocBuilder<RoomCubit, RoomState>(builder: (context, state) {
          if (state is RoomLoading) {
            return const CcLoadingWidget();
          } else if (state is RoomLoaded) {
            return _buildList(state.rooms);
          } else {
            return _buildList([]);
          }
        }),
      ),
    );
  }

  Widget _buildList(List<RoomModel> rooms) {
    return CcBuildingRoomsTemplate(
      header: _buildHeader(),
      title: 'Habitaciones',
      filters: _buildFilters(),
      content: _buildContent(rooms),
      actions: _buildActions(),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ValueListenableBuilder<Map<String, String>?>(
        valueListenable: selectedRoomNotifier,
        builder: (context, selectedRoom, _) {
          return CcItemListWidget(
            iconType: IconType.enabled,
            title: widget.building.name,
            content: CcItemBuildingContentWidget(
              room: selectedRoom?['identifier']! ?? '...',
            ),
            icon: Icons.apartment,
            onTap: () {},
          );
        },
      ),
    );
  }

  Widget _buildFilters() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CcFiltersWidget(
          filters: const [
            'Todas',
            'En uso',
            'Disponibles',
            'Desocupadas',
            'Reportadas',
            'Limpias',
          ],
          onSelected: (filter) => _onFilterSelected(filter),
        ),
        const CcSymbologyWidget(
          grayLabel: 'En uso',
          whiteLabel: 'Disponible',
          greenLabel: 'Limpia',
          secondaryLabel: 'Desocupada',
          yellowLabel: 'Reportada',
        ),
      ],
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
          : Padding(
              padding: const EdgeInsets.only(bottom: 64.0),
              child: CustomScrollView(
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

                                return GestureDetector(
                                  onTap: roomState == RoomStatus.unoccupied ||
                                          roomState == RoomStatus.occupied
                                      ? () => selectedRoomNotifier.value = {
                                            'identifier': room.identifier,
                                            'id': room.id!,
                                          }
                                      : null,
                                  child: ValueListenableBuilder<
                                      Map<String, String>?>(
                                    valueListenable: selectedRoomNotifier,
                                    builder: (context, selectedRoom, _) {
                                      return CcRoomWidget(
                                        name: roomName,
                                        state: roomState,
                                        isSelected: selectedRoom != null &&
                                            selectedRoom['identifier'] ==
                                                roomId,
                                      );
                                    },
                                  ),
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
            ),
    );
  }

  Widget _buildActions() {
    return ValueListenableBuilder<Map<String, String>?>(
      valueListenable: selectedRoomNotifier,
      builder: (context, selectedRoom, _) {
        if (selectedRoom != null) {
          final room = widget.building.floors
              ?.expand((floor) => floor.rooms!)
              .firstWhere(
                  (room) => room.identifier == selectedRoom['identifier']);
          if (room != null) {
            final roomState = RoomStatus.values.firstWhere(
              (e) => e.toString() == 'RoomStatus.${room.status?.toLowerCase()}',
              orElse: () => RoomStatus.unoccupied,
            );
            return Row(
              children: [
                if (roomState == RoomStatus.occupied)
                  Expanded(
                    child: CcReportButtonWidget(
                      selectedRoomNotifier: selectedRoomNotifier,
                      buildingId: widget.building.id!,
                    ),
                  ),
                if (roomState == RoomStatus.unoccupied)
                  Expanded(
                    child: CcCleanButtonWidget(
                      building: widget.building,
                      selectedRoomNotifier: selectedRoomNotifier,
                    ),
                  ),
              ],
            );
          }
        }
        return const SizedBox.shrink();
      },
    );
  }
}
