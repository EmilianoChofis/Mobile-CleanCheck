import 'package:flutter/material.dart';
import 'package:mobile_clean_check/widgets/widgets.dart';
import 'package:mobile_clean_check/core/theme/themes.dart';

class IncidencesScreen extends StatefulWidget {
  const IncidencesScreen({super.key});

  @override
  State<IncidencesScreen> createState() => _IncidencesScreenState();
}

class _IncidencesScreenState extends State<IncidencesScreen> {
  final _searchController = SearchController();
  final primaryColor = ColorSchemes.primary;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CcAppBarWidget(
        title: 'Incidencias',
      ),
      body: CcListScreenTemplate(
        title: 'Lista de incidencias',
        search: _buildSearchBar(),
        filters: _buildFilters(),
        symbology: _buildSymbology(),
        content: _buildContent(),
      ),
    );
  }

  Widget _buildSearchBar() {
    return CcSearchBarWidget(controller: _searchController);
  }

  Widget _buildFilters() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: CcFiltersWidget(
        filters: const [
          'Todas',
          'En proceso',
          'Deshabilitadas',
          'Disponibles',
        ],
        onSelected: (filter) => print(filter),
      ),
    );
  }

  Widget _buildSymbology() {
    return const CcSymbologyWidget(
      grayLabel: 'Disponible',
      yellowLabel: 'En proceso',
      redLabel: 'Deshabilitada',
    );
  }

  Widget _buildContent() {
    return const CcListIncidencesWidget(
      content: [
        {
          'room': 'P1H10',
          'building': 'Rio Tiber',
          'date': '10/10/2021',
          'personal': 'Juan Perez',
          'status': 'IconType.enabled',
        },
        {
          'room': 'P1H11',
          'building': 'Edificio Palmira',
          'date': '10/10/2021',
          'personal': 'Juan Perez',
          'status': 'IconType.reported',
        },
        {
          'room': 'P1H12',
          'building': 'Edificio Alta Palmiraxddddddd',
          'date': '10/10/2021',
          'personal': 'Juan Perez',
          'status': 'IconType.disabled',
        },
      ],
    );
  }
}
