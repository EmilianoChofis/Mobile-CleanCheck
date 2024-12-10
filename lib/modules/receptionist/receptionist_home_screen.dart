import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_clean_check/data/cubits/cubits.dart';
import 'package:mobile_clean_check/modules/modules.dart';
import 'package:mobile_clean_check/widgets/widgets.dart';

class ReceptionistHomeScreen extends StatefulWidget {
  const ReceptionistHomeScreen({super.key});

  @override
  State<ReceptionistHomeScreen> createState() => _ReceptionistHomeScreenState();
}

class _ReceptionistHomeScreenState extends State<ReceptionistHomeScreen> {
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
          header: _buildHeader(),
          content: Column(
            children: [
              CcTitleContentTemplate(
                title: "Lista de Edificios",
                content: _buildBuildingsContent(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return CcWelcomeHomeTemplate(
      actions: CcWorkingZoneTemplate(
        title: "Acceso rápido",
        actions: CcWorkingZoneReceptionistWidget(
          onViewRooms: () {},
          onRegisterCheckIn: () {},
          onRegisterCheckOut: () {},
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
                        builder: (context) => ReceptionistBuildingScreen(
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
