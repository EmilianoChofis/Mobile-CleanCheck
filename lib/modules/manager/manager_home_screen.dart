import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_clean_check/data/cubits/cubits.dart';
import 'package:mobile_clean_check/data/models/models.dart';
import 'package:mobile_clean_check/data/services/services.dart';
import 'package:mobile_clean_check/widgets/organisms/cc_room_bottom_sheet_widget.dart';
import 'package:mobile_clean_check/widgets/widgets.dart';

class ManagerHomeScreen extends StatefulWidget {
  const ManagerHomeScreen({super.key});

  @override
  State<ManagerHomeScreen> createState() => _ManagerHomeScreenState();
}

class _ManagerHomeScreenState extends State<ManagerHomeScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _nameBuildingController = TextEditingController();
  final TextEditingController _numberFloorsController = TextEditingController();

  final TextEditingController _buildingsController = TextEditingController();
  final TextEditingController _floorsController = TextEditingController();
  final TextEditingController _roomsController = TextEditingController();

  @override
  void dispose() {
    _nameBuildingController.dispose();
    _numberFloorsController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    context.read<BuildingCubit>().getBuildings();
  }

  @override
  Widget build(BuildContext context) {
    return CcAppBlocListenerTemplate(
      child: Scaffold(
        appBar: const CcAppBarWidget(title: "Inicio"),
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

              _buildingsController.clear();
              _floorsController.clear();
              _roomsController.clear();
            }
          },
          child: BlocBuilder<BuildingCubit, BuildingState>(
            builder: (context, state) {
              if (state is BuildingLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is BuildingLoaded) {
                return _buildHome(state.buildings);
              } else {
                return _buildHome([]);
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _buildHome(List<BuildingModel> buildings) {
    return SingleChildScrollView(
      child: CcHeaderTemplate(
        header: _buildHeader(),
        content: _buildContent(buildings),
      ),
    );
  }

  void _showBuildingBottomSheet(BuildContext context,
      {BuildingModel? building}) {
    BuildingBottomSheet.show(context, building: building);
  }

  void _showRegisterRoomBottomSheet() {
    CcRoomBottomSheetWidget.show(context, quickAccess: true);
  }

  void _onSaveRoom() async {
    if (_formKey.currentState!.validate()) {
      final roomCubit = context.read<RoomCubit>();
      final roomService = RoomService();

      final rooms = await roomService.generateRooms(
        floorId: _floorsController.text,
        floorControllerText: _floorsController.text,
        roomsControllerText: _roomsController.text,
      );

      roomCubit.createListRooms(rooms);
    }
  }

  void _onCancel() {
    _nameBuildingController.clear();
    _numberFloorsController.clear();
    Navigator.pop(context);
  }

  Widget _buildHeader() {
    return CcWelcomeHomeTemplate(
      actions: Column(
        children: [
          CcWorkingZoneTemplate(
            title: "Incidencias",
            actions: CcBannerWidget(
              icon: Icons.warning_amber,
              text: "3 incidencias pendientes",
              trailing: Icons.chevron_right,
              onTap: () => print("Incidencias"),
            ),
          ),
          const SizedBox(height: 16.0),
          CcWorkingZoneTemplate(
            title: "Accesos directos",
            actions: CcWorkingZoneManagerWidget(
              onRegisterBuilding: () => _showBuildingBottomSheet(context),
              onRegisterRoom: _showRegisterRoomBottomSheet,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContent(List<BuildingModel> buildings) {
    final buildingItems = buildings.take(3).map((building) {
      final f = building.floors?.length ?? 0;
      final ft = f != 1 ? '$f pisos' : '$f piso';
      return {'name': building.name, 'rooms': ft};
    }).toList();

    return Column(
      children: [
        CcTitleContentTemplate(
          title: "Edificios",
          content: Column(
            children: [
              if (buildingItems.isEmpty)
                const CcBannerWidget(
                  icon: Icons.apartment_outlined,
                  text: 'Aquí se mostrarán los edificios registrados',
                  trailing: Icons.chevron_right,
                )
              else ...[
                CcListItemsWidget(items: buildingItems),
                CcButtonWidget(
                  buttonType: ButtonType.text,
                  label: "Ver más",
                  suffixIcon: const Icon(Icons.chevron_right),
                  onPressed: () => print("Edificios"),
                  isLoading: false,
                ),
              ],
            ],
          ),
        ),
        const SizedBox(height: 16.0),
        CcTitleContentTemplate(
          title: "Usuarios",
          content: Column(
            children: [
              const CcListItemsWidget(
                items: [
                  {
                    'name': 'Juan Perez',
                    'rooms': 'Administrador',
                  },
                  {
                    'name': 'Maria Lopez',
                    'rooms': 'Limpieza',
                  },
                  {
                    'name': 'Pedro Ramirez',
                    'rooms': 'Mantenimiento',
                  },
                ],
              ),
              CcButtonWidget(
                buttonType: ButtonType.text,
                label: "Ver más",
                suffixIcon: const Icon(Icons.chevron_right),
                onPressed: () => print("Usuarios"),
                isLoading: false,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
