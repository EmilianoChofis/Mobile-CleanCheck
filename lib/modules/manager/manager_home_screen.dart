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
    context.read<UserCubit>().getUsers();
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
                title: "Edificios",
                content: _buildBuildingsContent(),
              ),
              const SizedBox(height: 16.0),
              CcTitleContentTemplate(
                title: "Usuarios",
                content: _buildUsersContent(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showBuildingBottomSheet(BuildContext context,
      {BuildingModel? building}) {
    CcBuildingBottomSheetWidget.show(context, building: building);
  }

  void _showRoomBottomSheet() {
    CcRoomBottomSheetWidget.show(context, quickAccess: true);
  }

  void _showUserBottomSheet() {
    CcUserBottomSheetWidget.show(context);
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
              onTap: () => {},
            ),
          ),
          const SizedBox(height: 16.0),
          CcWorkingZoneTemplate(
            title: "Accesos directos",
            actions: CcWorkingZoneManagerWidget(
              onRegisterBuilding: () => _showBuildingBottomSheet(context),
              onRegisterRoom: _showRoomBottomSheet,
              onRegisterUser: _showUserBottomSheet,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBuildingsContent() {
    return BlocBuilder<BuildingCubit, BuildingState>(
      builder: (context, state) {
        if (state is BuildingLoaded) {
          final buildings = state.buildings.take(3).map((building) {
            final f = building.floors?.length ?? 0;
            final ft = f != 1 ? '$f pisos' : '$f piso';
            return {'name': building.name, 'rooms': ft};
          }).toList();

          return Column(
            children: [
              if (buildings.isEmpty)
                const CcBannerWidget(
                  icon: Icons.apartment_outlined,
                  text: 'Aquí se mostrarán los edificios registrados',
                  trailing: Icons.chevron_right,
                )
              else ...[
                CcListItemsWidget(items: buildings),
                CcButtonWidget(
                  buttonType: ButtonType.text,
                  label: "Ver más",
                  suffixIcon: const Icon(Icons.chevron_right),
                  onPressed: () {},
                  isLoading: false,
                ),
              ],
            ],
          );
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }

  Widget _buildUsersContent() {
    return BlocBuilder<UserCubit, UserState>(
      builder: (context, state) {
        if (state is UsersLoaded) {
          final users = state.users.take(3).map((user) {
            return {'name': user.name, 'rooms': user.email};
          }).toList();

          return Column(
            children: [
              if (users.isEmpty)
                const CcBannerWidget(
                  icon: Icons.person_outline,
                  text: 'Aquí se mostrarán los usuarios registrados',
                  trailing: Icons.chevron_right,
                )
              else ...[
                CcListItemsWidget(items: users),
                CcButtonWidget(
                  buttonType: ButtonType.text,
                  label: "Ver más",
                  suffixIcon: const Icon(Icons.chevron_right),
                  onPressed: () => {},
                  isLoading: false,
                ),
              ],
            ],
          );
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
