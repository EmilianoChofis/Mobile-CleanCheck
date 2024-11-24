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
  @override
  void initState() {
    super.initState();
    context.read<BuildingCubit>().getBuildings();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CcAppBarWidget(title: "Inicio"),
      body: BlocBuilder<BuildingCubit, BuildingState>(
        builder: (context, state) {
          if (state is BuildingLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is BuildingLoaded) {
            return SingleChildScrollView(
              child: CcHeaderTemplate(
                header: _buildHeader(),
                content: _buildContent(state.buildings),
              ),
            );
          } else if (state is BuildingError) {
            return Center(child: Text('Error: ${state.message}'));
          } else {
            return const Center(child: Text('No hay información disponible.'));
          }
        },
      ),
    );
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
          const CcWorkingZoneTemplate(
            title: "Accesos directos",
            actions: CcWorkingZoneManagerWidget(),
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
                onPressed: () => print("Edificios"),
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
