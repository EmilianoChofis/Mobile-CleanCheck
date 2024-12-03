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
        onPressed: () => _showBuildingBottomSheet(context),
        icon: Icons.add,
      ),
      body: CcAppBlocListenerTemplate(
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
      onRefresh: () async {
        await context.read<BuildingCubit>().getBuildings();
      },
      child: buildings.isEmpty
          ? const Center(child: Text('No hay edificios registrados.'))
          : CcListSlidableWidget<BuildingModel>(
              items: buildings,
              onEdit: (context, {item}) {
                _showBuildingBottomSheet(context, building: item);
              },
              onDelete: (context, {item}) {},
              buildItem: (context, building) {
                final f = building.floors?.length ?? 0;
                final ft = f != 1 ? '$f pisos' : '$f piso';

                return CcItemListWidget(
                  iconType: IconType.enabled,
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) =>
                            ManagerRoomsScreen(building: building),
                      ),
                    );
                  },
                  icon: Icons.domain_outlined,
                  title: building.name,
                  content: Text(ft),
                );
              },
            ),
    );
  }

  void _showBuildingBottomSheet(BuildContext context,
      {BuildingModel? building}) {
    BuildingBottomSheet.show(context, building: building);
  }
}
