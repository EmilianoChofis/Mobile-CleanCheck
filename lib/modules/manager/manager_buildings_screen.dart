import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_clean_check/data/cubits/cubits.dart';
import 'package:mobile_clean_check/data/models/models.dart';
import 'package:mobile_clean_check/modules/modules.dart';
import 'package:mobile_clean_check/widgets/widgets.dart';

class ManagerBuildingsScreen extends StatefulWidget {
  const ManagerBuildingsScreen({super.key});

  @override
  State<ManagerBuildingsScreen> createState() => _ManagerBuildingsScreenState();
}

class _ManagerBuildingsScreenState extends State<ManagerBuildingsScreen> {
  final _searchController = SearchController();

  @override
  void initState() {
    super.initState();
    context.read<BuildingCubit>().getBuildings();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CcAppBarWidget(title: 'Edificios'),
      floatingActionButton: CcFabWidget(
        onPressed: () => _showBuildingBottomSheet(context, null),
        icon: Icons.add,
      ),
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
          }
        },
        child: BlocBuilder<BuildingCubit, BuildingState>(
          builder: (context, state) {
            if (state is BuildingLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is BuildingLoaded) {
              return _buildList(state.buildings);
            } else {
              return _buildList([]);
            }
          },
        ),
      ),
    );
  }

  Widget _buildList(List<BuildingModel> buildings) {
    return CcListScreenTemplate(
      title: 'Lista de edificios',
      search: CcSearchBarWidget(controller: _searchController),
      filters: _buildFilters(),
      symbology: _buildSymbology(),
      content: _buildContent(buildings),
    );
  }

  Widget _buildFilters() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: CcFiltersWidget(
        filters: const ['Todos', 'Activos', 'Deshabilitados'],
        onSelected: (filter) => _onFilterSelected(filter),
      ),
    );
  }

  void _onFilterSelected(String filter) {
    print('Filtro seleccionado: $filter');
  }

  Widget _buildSymbology() {
    return const CcSymbologyWidget(
      grayLabel: 'Activo',
      redLabel: 'Deshabilitado',
    );
  }

  Widget _buildContent(List<BuildingModel> buildings) {
    return RefreshIndicator(
      onRefresh: () async => await context.read<BuildingCubit>().getBuildings(),
      child: buildings.isEmpty
          ? const Center(child: Text('No hay edificios registrados.'))
          : CcListSlidableWidget<BuildingModel>(
              items: buildings,
              onEdit: (context, {item}) {
                _showBuildingBottomSheet(context, item);
              },
              onDelete: (context, {item}) {
                _showChangeStatusBottomSheet(
                  context,
                  item!,
                  item.status! ? IconType.enabled : IconType.disabled,
                );
              },
              buildItem: (context, b) {
                final floors = b.floors?.length ?? 0;
                final floorText =
                    floors != 1 ? '$floors pisos' : '$floors piso';
                final it = b.status! ? IconType.enabled : IconType.disabled;

                return CcItemListWidget(
                  iconType: it,
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => ManagerRoomsScreen(building: b),
                      ),
                    );
                  },
                  icon: Icons.domain_outlined,
                  title: b.name,
                  content: Text(floorText),
                );
              },
            ),
    );
  }

  void _showBuildingBottomSheet(BuildContext context, BuildingModel? building) {
    CcBuildingBottomSheetWidget.show(context, building: building);
  }

  void _showChangeStatusBottomSheet(
      BuildContext context, BuildingModel building, IconType iconType) {
    CcChangeStatusBottomSheetWidget.show(
      context,
      item: building,
      title: building.status! ? 'Deshabilitar edificio' : 'Habilitar edificio',
      cardTitle: building.name,
      cardSubtitle: '${building.floors!.length} pisos',
      cardType: iconType,
      cardIcon: Icons.domain_outlined,
      content: const Text('¿Estás seguro de deshabilitar este edificio?'),
      onDelete: (id) => context.read<BuildingCubit>().deleteBuilding(id),
    );
  }
}
