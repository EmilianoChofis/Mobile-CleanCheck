import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:mobile_clean_check/core/theme/themes.dart';
import 'package:mobile_clean_check/data/cubits/cubits.dart';
import 'package:mobile_clean_check/data/models/models.dart';
import 'package:mobile_clean_check/widgets/widgets.dart';

class ReceptionistBuildingScreen extends StatefulWidget {
  final BuildingModel building;

  const ReceptionistBuildingScreen({required this.building, super.key});

  @override
  State<ReceptionistBuildingScreen> createState() =>
      _ReceptionistBuildingScreenState();
}

class _ReceptionistBuildingScreenState
    extends State<ReceptionistBuildingScreen> {
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
      appBar: const CcAppBarWidget(title: 'Marcar entradas'),
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
            'Sin limpiar',
            'Limpias',
            'Reportadas',
            'Deshabilitadas',
          ],
          onSelected: (filter) {},
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
                                        'RoomStatus.${room.status?.toLowerCase()}');

                                final isSelectable =
                                    roomState == RoomStatus.checked ||
                                        roomState == RoomStatus.occupied;

                                return GestureDetector(
                                  onTap: isSelectable
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
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              ValueListenableBuilder<Map<String, String>?>(
                valueListenable: selectedRoomNotifier,
                builder: (context, selectedRoom, _) {
                  final selectedRoomId = selectedRoom?['id'];
                  final selectedRoomState = widget.building.floors
                      ?.expand((floor) => floor.rooms ?? [])
                      .firstWhere(
                        (room) => room.id == selectedRoomId,
                        orElse: () => null,
                      )
                      ?.status;

                  return CcCheckButtonWidget(
                    selectedRoomState: selectedRoomState,
                    building: widget.building,
                    selectedRoomNotifier: selectedRoomNotifier,
                  );
                },
              ),
            ],
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
