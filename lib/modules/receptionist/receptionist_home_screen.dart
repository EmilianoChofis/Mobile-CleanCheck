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
    _fetchData();
  }

  Future<void> _fetchData() async {
    context.read<BuildingCubit>().getBuildingsActives();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CcAppBarWidget(title: "Inicio"),
      body: RefreshIndicator(
        onRefresh: _fetchData,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: CcHeaderTemplate(
            header: _buildHeader(),
            content: _buildContent(),
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

  Widget _buildContent() {
    return CcTitleContentTemplate(
      title: 'Lista de edificios',
      content: BlocBuilder<BuildingCubit, BuildingState>(
        builder: (context, state) {
          if (state is BuildingLoading) {
            return const CcLoadingWidget();
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

            return CcListItemsWidget(
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
          return Center(
            child: CcLoadedErrorWidget(
              title: "Ha ocurrido un error al cargar los edificios",
              onRetry: () => context.read<BuildingCubit>().getBuildings(),
            ),
          );
        },
      ),
    );
  }
}
