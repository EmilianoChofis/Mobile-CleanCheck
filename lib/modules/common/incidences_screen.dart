import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_clean_check/data/cubits/cubits.dart';
import 'package:mobile_clean_check/data/models/models.dart';
import 'package:mobile_clean_check/modules/modules.dart';
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
  void initState() {
    super.initState();
    context.read<ReportCubit>().getReports();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CcAppBarWidget(title: 'Incidencias'),
      body: BlocListener<ReportCubit, ReportState>(
        listener: (context, state) {
          if (state is ReportError) {
            CcSnackBarWidget.show(
              context,
              message: state.message,
              snackBarType: SnackBarType.error,
            );
          } else if (state is ReportSuccess) {
            CcSnackBarWidget.show(
              context,
              message: state.message,
              snackBarType: SnackBarType.success,
            );
          }
        },
        child: BlocBuilder<ReportCubit, ReportState>(
          builder: (context, state) {
            if (state is ReportLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is ReportsLoaded) {
              return _buildList(state.reports);
            } else {
              return _buildList([]);
            }
          },
        ),
      ),
    );
  }

  Widget _buildList(List<ReportModel> reports) {
    return CcListScreenTemplate(
      title: 'Lista de incidencias',
      search: _buildSearchBar(),
      filters: _buildFilters(),
      symbology: _buildSymbology(),
      content: _buildContent(reports),
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

  Widget _buildContent(List<ReportModel> reports) {
    return RefreshIndicator(
      onRefresh: () async => context.read<ReportCubit>().getReports(),
      child: reports.isEmpty
          ? const Center(child: Text('No hay incidencias'))
          : ListView.builder(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.all(8.0),
              itemCount: reports.length,
              itemBuilder: (context, index) {
                final item = reports[index];
                final iconType = _parseIconType(item.status);
                return Column(
                  children: [
                    CcItemListWidget(
                      iconType: iconType,
                      onTap: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                          return IncidenceDetailScreen(report: item);
                        }));
                      },
                      icon: Icons.bed_outlined,
                      title: 'Habitación ${item.room?.identifier}',
                      content: CcItemIncidencesContentWidget(
                        status: _interpretStatus(iconType),
                        buildingName: item.room!.floor!.building!.name,
                        personal: item.user?.name,
                        date: item.createdAt!,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                  ],
                );
              },
            ),
    );
  }

  IconType _parseIconType(String? status) {
    switch (status) {
      case 'PENDING':
        return IconType.reported;
      case 'IN_PROGRESS':
        return IconType.disabled;
      case 'FINISHED':
        return IconType.enabled;
      default:
        return IconType.displayed;
    }
  }

  String _interpretStatus(IconType iconType) {
    switch (iconType) {
      case IconType.displayed:
        return '';
      case IconType.enabled:
        return 'Finalizado';
      case IconType.reported:
        return 'Pendiente';
      case IconType.disabled:
        return 'En progreso';
    }
  }
}
