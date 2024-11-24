import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_clean_check/core/configs/show_custom_bottom_sheet.dart';
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
  void initState() {
    super.initState();
    context.read<BuildingCubit>().getBuildings();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CcAppBarWidget(title: 'Edificios'),
      floatingActionButton: CcFabBuildingWidget(
        onPressed: () => _buildingBottomSheetForm(context),
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
            Navigator.pop(context);
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
              return const Center(
                child: Text('No hay información disponible.'),
              );
            }
          },
        ),
      ),
    );
  }

  Widget _buildList(List<BuildingModel> buildings, [String? errorMessage]) {
    return CcListScreenTemplate(
      title: 'Lista de edificios',
      search: CcSearchBarWidget(controller: _searchController),
      filters: _buildFilters(),
      symbology: _buildSymbology(),
      content: _buildContent(buildings, errorMessage),
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

  Widget _buildContent(List<BuildingModel> buildings, String? errorMessage) {
    if (errorMessage != null) {
      return Center(child: Text(errorMessage));
    }

    if (buildings.isEmpty) {
      return const Center(child: Text('No hay edificios registrados.'));
    }

    return CcListSlidableWidget<BuildingModel>(
      items: buildings,
      onEdit: (context, {item}) =>
          _buildingBottomSheetForm(context, building: item),
      onDelete: (context, {item}) {},
      buildItem: (context, building) {
        return CcItemListWidget(
          iconType: IconType.enabled,
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const MaidBuildingScreen(),
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

  void _buildingBottomSheetForm(BuildContext context,
      {BuildingModel? building}) {
    if (building != null) {
      _nameBuildingController.text = building.name;
      _numberFloorsController.text = building.number.toString();
    }

    showCustomBottomSheet(
      context,
      title: building == null ? 'Registrar edificio' : 'Editar edificio',
      content: CcRegisterBuildingFormWidget(
        formKey: _formKey,
        nameBuildingController: _nameBuildingController,
        numberFloorsController: _numberFloorsController,
      ),
      actions: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          CcButtonWidget(
            buttonType: ButtonType.elevated,
            onPressed: () => _onSave(building),
            label: building == null ? 'Registrar' : 'Actualizar',
            isLoading: false,
          ),
          const SizedBox(height: 8.0),
          CcButtonWidget(
            buttonType: ButtonType.outlined,
            onPressed: _onCancel,
            label: "Cancelar",
            isLoading: false,
          ),
        ],
      ),
    );
  }

  void _onSave(BuildingModel? building) {
    if (_formKey.currentState!.validate()) {
      final newBuilding = BuildingModel(
        name: _nameBuildingController.text,
        number: int.parse(_numberFloorsController.text),
      );

      if (building == null) {
        context.read<BuildingCubit>().createBuilding(newBuilding);
      } else {
        context.read<BuildingCubit>().updateBuilding(
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
