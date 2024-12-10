import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_clean_check/data/cubits/cubits.dart';
import 'package:mobile_clean_check/modules/maid/maid_building_screen.dart';
import 'package:mobile_clean_check/widgets/widgets.dart';

class MaidHomeScreen extends StatefulWidget {
  const MaidHomeScreen({super.key});

  @override
  State<MaidHomeScreen> createState() => _MaidHomeScreenState();
}

class _MaidHomeScreenState extends State<MaidHomeScreen> {
  @override
  void initState() {
    super.initState();
    context.read<BuildingCubit>().getBuildings();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CcAppBarWidget(title: "Inicio"),
      body: SingleChildScrollView(
        child: CcHeaderTemplate(
          header: const CcWelcomeHomeTemplate(
            actions: CcWorkingZoneTemplate(
                title: "Zonas de trabajo", actions: CcWorkingZoneMaidWidget()),
          ),
          content: CcTitleContentTemplate(
            title: 'Lista de edificios',
            content: _buildBuildingsContent(),
          ),
        ),
      ),
    );
  }

  Widget _buildBuildingsContent() {
    return BlocBuilder<BuildingCubit, BuildingState>(
      builder: (context, state) {
        if (state is BuildingLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is BuildingLoaded) {
          final buildings = state.buildings.map((building) {
            final floors = building.floors?.length ?? 0;
            final floorLabel = floors != 1 ? "$floors pisos" : "$floors piso";
            return {
              'name': building.name,
              'rooms': floorLabel,
              'building': building
            };
          }).toList();

          return buildings.isEmpty
              ? const Center(child: Text('No hay edificios registrados.'))
              : CcListItemsWidget(
                  items: buildings,
                  icon: Icons.apartment_outlined,
                  onTap: (item) {
                    final selectedBuilding = item['building'];
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => MaidBuildingScreen(
                          building: selectedBuilding,
                        ),
                      ),
                    );
                  },
                );
        }
        return const Center(
          child: Text("Ocurrió un error al cargar los edificios."),
        );
      },
    );
  }
}
