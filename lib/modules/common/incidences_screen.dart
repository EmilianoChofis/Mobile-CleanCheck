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
        search: SearchBar(
          controller: _searchController,
          hintText: 'Buscar...',
          trailing: const [Icon(Icons.search)],
          padding: const WidgetStatePropertyAll<EdgeInsets>(
            EdgeInsets.symmetric(horizontal: 16),
          ),
          elevation: WidgetStateProperty.all(0.0),
          side: WidgetStateProperty.all(BorderSide(color: primaryColor)),
        ),
        filters: Padding(
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
        ),
        symbology: const CcSymbologyWidget(
          grayLabel: 'Disponible',
          yellowLabel: 'En proceso',
          redLabel: 'Deshabilitada',
        ),
        content: const CcListItemsWidget(
          content: [
            {
              'name': 'Edificio 1',
              'rooms': 'Habitaciones: 10',
            },
            {
              'name': 'Edificio 2',
              'rooms': 'Habitaciones: 20',
            },
            {
              'name': 'Edificio 3',
              'rooms': 'Habitaciones: 30',
            },
          ],
        ),
      ),
    );
  }
}
