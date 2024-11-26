import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_clean_check/core/theme/themes.dart';
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
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameBuildingController = TextEditingController();
  final TextEditingController _numberFloorsController = TextEditingController();
  final _searchController = SearchController();

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
      appBar: const CcAppBarWidget(title: 'Edificios'),
      floatingActionButton: CcFabWidget(
        onPressed: () => _showBuildingBottomSheet(context),
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

            _nameBuildingController.clear();
            _numberFloorsController.clear();
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
    if (buildings.isEmpty) {
      return const Center(child: Text('No hay edificios registrados.'));
    }

    return CcListSlidableWidget<BuildingModel>(
      items: buildings,
      onEdit: (context, {item}) =>
          _showBuildingBottomSheet(context, building: item),
      onDelete: (context, {item}) {},
      buildItem: (context, building) {
        return CcItemListWidget(
          iconType: IconType.enabled,
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => ManagerRoomsScreen(building: building),
              ),
            );
          },
          icon: Icons.domain_outlined,
          title: building.name,
          content: Text(
            '${building.number} pisos',
            style: const TextStyle(color: ColorSchemes.secondary),
          ),
        );
      },
    );
  }

  void _showBuildingBottomSheet(BuildContext context,
      {BuildingModel? building}) {
    BuildingBottomSheet.show(
      context,
      formKey: _formKey,
      nameBuildingController: _nameBuildingController,
      numberFloorsController: _numberFloorsController,
      building: building,
      onSave: (building) => _onSave(building),
      onCancel: () => _onCancel(),
    );
  }

  void _onSave(BuildingModel? building) {
    if (_formKey.currentState!.validate()) {
      final newBuilding = BuildingModel(
        name: _nameBuildingController.text,
        number: int.parse(_numberFloorsController.text),
      );

      if (building == null) {
        context.read<BuildingCubit>().createBuildingWithFloors(newBuilding);
      } else {
        context.read<BuildingCubit>().updateBuildingWithFloors(
              building.copyWith(
                name: newBuilding.name,
                number: newBuilding.number,
              ),
            );
      }
    }
  }

  void _onCancel() {
    _nameBuildingController.clear();
    _numberFloorsController.clear();
    Navigator.pop(context);
  }
}
