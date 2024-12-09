import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_clean_check/core/configs/show_custom_bottom_sheet.dart';
import 'package:mobile_clean_check/data/cubits/user/user_cubit.dart';
import 'package:mobile_clean_check/data/models/user_model.dart';
import 'package:mobile_clean_check/widgets/widgets.dart';

class CcUserBottomSheetWidget {
  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  static final TextEditingController _nameController = TextEditingController();
  static final TextEditingController _emailController = TextEditingController();
  static final TextEditingController _passwordController =
      TextEditingController();
  static final TextEditingController _roleController = TextEditingController();

  static void show(
    BuildContext context, {
    UserModel? user,
  }) {
    if (user != null) {
      _nameController.text = user.name;
      _emailController.text = user.email;
      _roleController.text = user.role!.id;
    } else {
      _nameController.clear();
      _emailController.clear();
      _passwordController.clear();
      _roleController.clear();
    }

    showCustomBottomSheet(
      context,
      title: user == null ? 'Registrar usuario' : 'Editar usuario',
      content: CcUserFormWidget(
        user: user,
        formKey: _formKey,
        nameController: _nameController,
        emailController: _emailController,
        passwordController: _passwordController,
        roleController: _roleController,
      ),
      actions: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          CcButtonWidget(
            buttonType: ButtonType.elevated,
            onPressed: () => _onSave(context, user),
            label: user == null ? 'Registrar' : 'Actualizar',
            isLoading: false,
          ),
          const SizedBox(height: 8.0),
          CcButtonWidget(
            buttonType: ButtonType.outlined,
            onPressed: () => _onCancel(context),
            label: "Cancelar",
            isLoading: false,
          ),
        ],
      ),
    );
  }

  static void _onSave(BuildContext context, UserModel? user) async {
    if (_formKey.currentState!.validate()) {
      final userCubit = context.read<UserCubit>();
      if (user == null) {
        final newUser = UserModel(
          name: _nameController.text,
          email: _emailController.text,
          password: _passwordController.text,
        );
        final role = _roleController.text;
        userCubit.createUser(newUser, role);

      } else {
        final updatedUser = UserModel(
          id: user.id,
          name: _nameController.text,
          email: _emailController.text,
          password: _passwordController.text,
          roleId: _roleController.text,
        );
        userCubit.updateUser(updatedUser);
      }
      _onCancel(context);
    }
  }

  static void _onCancel(BuildContext context) {
    _nameController.clear();
    _emailController.clear();
    _passwordController.clear();
    _roleController.clear();
    Navigator.pop(context);
  }
}
