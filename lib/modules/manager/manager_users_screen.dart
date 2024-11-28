import 'package:flutter/material.dart';
import 'package:mobile_clean_check/widgets/widgets.dart';

class ManagerUsersScreen extends StatelessWidget {
  const ManagerUsersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CcAppBarWidget(title: 'Usuarios'),
      body: _buildContent(),
    );
  }

  Widget _buildContent() {
    return CcListScreenTemplate(
      title: 'Lista de usuarios',
      search: _buildSearchBar(),
      filters: CcFiltersWidget(filters: const [
        'Todos',
        'Personal de limpieza',
        'Recepcionista',
      ], onSelected:(value) => print(value)),
      symbology: const CcSymbologyWidget(
        grayLabel: 'Activo',
        redLabel: 'Deshabilitados',
      ),
      content: const Text('data'),
    );
  }

  Widget _buildSearchBar() {
    return const Text('data');
  }
}
