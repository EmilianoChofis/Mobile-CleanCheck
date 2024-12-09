import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_clean_check/core/theme/themes.dart';
import 'package:mobile_clean_check/data/cubits/user/user_cubit.dart';
import 'package:mobile_clean_check/data/cubits/user/user_state.dart';
import 'package:mobile_clean_check/data/models/models.dart';
import 'package:mobile_clean_check/widgets/widgets.dart';

class ManagerUsersScreen extends StatefulWidget {
  const ManagerUsersScreen({super.key});

  @override
  State<ManagerUsersScreen> createState() => _ManagerUsersScreenState();
}

class _ManagerUsersScreenState extends State<ManagerUsersScreen> {
  final _searchController = SearchController();

  @override
  void initState() {
    super.initState();
    context.read<UserCubit>().getUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CcAppBarWidget(title: 'Usuarios'),
      floatingActionButton: CcFabWidget(
        onPressed: () => _showUserBottomSheet(context, null),
        icon: Icons.add,
      ),
      body: BlocListener<UserCubit, UserState>(
        listener: (context, state) {
          if (state is UserError) {
            CcSnackBarWidget.show(
              context,
              message: state.message,
              snackBarType: SnackBarType.error,
            );
          } else if (state is UserSuccess) {
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
        child: BlocBuilder<UserCubit, UserState>(
          builder: (context, state) {
            if (state is UserLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is UsersLoaded) {
              return _buildList(state.users);
            } else {
              return _buildList([]);
            }
          },
        ),
      ),
    );
  }

  Widget _buildList(List<UserModel> users) {
    return CcListScreenTemplate(
      title: 'Lista de usuarios',
      search: CcSearchBarWidget(controller: _searchController),
      filters: _buildFilters(),
      symbology: _buildSymbology(),
      content: _buildContent(users),
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

  Widget _buildContent(List<UserModel> users) {
    if (users.isEmpty) {
      return const Center(child: Text('No hay usuarios registrados.'));
    }

    return CcListSlidableWidget<UserModel>(
      items: users,
      onEdit: (context, {item}) => _showUserBottomSheet(context, item),
      onDelete: (context, {item}) => _onDeleteUser(item),
      buildItem: (context, user) {
        return CcItemListWidget(
          iconType: IconType.enabled,
          onTap: () => _showUserBottomSheet(context, user),
          icon: Icons.person_outline,
          title: user.name,
          content: Text(
            user.email,
            style: const TextStyle(color: ColorSchemes.secondary),
          ),
        );
      },
    );
  }

  void _showUserBottomSheet(BuildContext context, UserModel? user) {
    CcUserBottomSheetWidget.show(context, user: user);
  }

  void _onDeleteUser(UserModel? user) {
    if (user != null) {
      // context.read<UserCubit>().deleteUser(user);
    }
  }
}
