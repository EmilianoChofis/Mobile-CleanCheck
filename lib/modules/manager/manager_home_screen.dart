import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_clean_check/data/cubits/cubits.dart';
import 'package:mobile_clean_check/data/models/models.dart';
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
    return Scaffold(
      appBar: const CcAppBarWidget(title: "Inicio"),
      body: BlocListener<BuildingCubit, BuildingState>(
        listener: (context, state) {
          if (state is BuildingError) {
            CcSnackBarWidget.show(
              context,
              message: state.message,
              snackBarType: SnackBarType.error,
            );
          } else if (state is BuildingSuccess) {
            CcSnackBarWidget.show(
              context,
              message: state.message,
              snackBarType: SnackBarType.success,
            );

            if (Navigator.canPop(context)) {
              Navigator.pop(context);
            }

            _nameBuildingController.clear();
            _numberFloorsController.clear();
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

  void _showRegisterBuildingBottomSheet() {
    BuildingBottomSheet.show(
      context,
      formKey: _formKey,
      nameBuildingController: _nameBuildingController,
      numberFloorsController: _numberFloorsController,
      onSave: (building) => _onSave(),
      onCancel: () => _onCancel(),
    );
  }

  void _onSave() {
    if (_formKey.currentState!.validate()) {
      final newBuilding = BuildingModel(
        name: _nameBuildingController.text,
        number: int.parse(_numberFloorsController.text),
      );

      context.read<BuildingCubit>().createBuildingWithFloors(newBuilding);
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
              onRegisterBuilding: _showRegisterBuildingBottomSheet,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContent(List<BuildingModel> buildings) {
    final buildingItems = buildings
        .take(3)
        .map((building) => {
              'name': building.name,
              'rooms': '${building.number} habitaciones',
            })
        .toList();

    return Column(
      children: [
        CcTitleContentTemplate(
          title: "Edificios",
          content: Column(
            children: [
              CcListItemsWidget(items: buildingItems),
              CcButtonWidget(
                buttonType: ButtonType.text,
                label: "Ver más",
                suffixIcon: const Icon(Icons.chevron_right),
                onPressed: () => {print("Edificios")},
                isLoading: false,
              ),
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
