import 'package:flutter/material.dart';
import 'package:mobile_clean_check/data/models/models.dart';
import 'package:mobile_clean_check/widgets/widgets.dart';

class CcUserFormWidget extends StatefulWidget {
  final UserModel? user;
  final GlobalKey<FormState> formKey;
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController roleController;
  final TextEditingController passwordController;

  const CcUserFormWidget({
    this.user,
    required this.formKey,
    required this.nameController,
    required this.emailController,
    required this.roleController,
    required this.passwordController,
    super.key,
  });

  @override
  State<CcUserFormWidget> createState() => _CcUserFormWidgetState();
}

class _CcUserFormWidgetState extends State<CcUserFormWidget> {
  @override
  void initState() {
    super.initState();
    widget.passwordController.addListener(_onPasswordChanged);
  }

  @override
  void dispose() {
    widget.passwordController.removeListener(_onPasswordChanged);
    super.dispose();
  }

  void _onPasswordChanged() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: widget.formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            CcTextFormFieldWidget(
              controller: widget.nameController,
              icon: const Icon(Icons.person_outline),
              hint: 'Ingresa el nombre',
              keyboardType: TextInputType.text,
              label: 'Nombre',
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'El nombre es requerido';
                }
                return null;
              },
            ),
            const SizedBox(height: 32.0),
            CcTextFormFieldWidget(
              controller: widget.emailController,
              icon: const Icon(Icons.email_outlined),
              hint: 'Ingresa el correo electrónico',
              keyboardType: TextInputType.emailAddress,
              label: 'Correo electrónico',
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'El correo electrónico es requerido';
                }
                if (!RegExp(r'^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$')
                    .hasMatch(value)) {
                  return 'Ingresa un correo electrónico válido';
                }
                return null;
              },
            ),
            const SizedBox(height: 32.0),
            if (widget.user == null) ...[
              CcDropDownWidget(
                controller: widget.roleController,
                hint: 'Selecciona el rol',
                label: 'Rol',
                items: const [
                  DropdownMenuItem(
                    value: 'Maid',
                    child: Text('Personal de limpieza'),
                  ),
                  DropdownMenuItem(
                    value: 'Receptionist',
                    child: Text('Recepcionista'),
                  ),
                ],
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'El rol es requerido';
                  }
                  return null;
                },
                icon: const Icon(Icons.person_outline),
              ),
              const SizedBox(height: 32.0),
              CcTextFormFieldPasswordWidget(
                controller: widget.passwordController,
                hint: 'Ingresa la contraseña',
                label: 'Contraseña',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'La contraseña es requerida';
                  }
                  return null;
                },
              ),
              if (widget.passwordController.text.isNotEmpty)
                CcSecureProgressPasswordWidget(
                  password: widget.passwordController.text,
                ),
              const SizedBox(height: 32.0),
            ]
          ],
        ),
      ),
    );
  }
}
