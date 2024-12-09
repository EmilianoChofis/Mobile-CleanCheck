import 'package:flutter/material.dart';
import 'package:mobile_clean_check/core/theme/themes.dart';
import 'package:mobile_clean_check/widgets/widgets.dart';

class CcChangePasswordFormWidget extends StatefulWidget {
  const CcChangePasswordFormWidget({super.key});

  @override
  State<CcChangePasswordFormWidget> createState() =>
      _CcChangePasswordFormWidgetState();
}

class _CcChangePasswordFormWidgetState
    extends State<CcChangePasswordFormWidget> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  final tooltip =
      "Debe contener al menos 8 caracteres\nDebe contener al menos una letra mayúscula\nDebe contener al menos una letra minúscula\nDebe contener al menos un número\nDebe contener al menos un caracter especial";

  @override
  void initState() {
    super.initState();
    _passwordController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Cambiar contraseña",
            style: TextThemes.lightTextTheme.headlineSmall,
          ),
          const SizedBox(height: 40.0),
          CcTextFormFieldPasswordWidget(
            controller: _passwordController,
            label: "Nueva contraseña",
            hint: "Ingresa tu contraseña",
            tooltip: tooltip,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Ingresa tu contraseña";
              }
              return null;
            },
          ),
          if (_passwordController.text.isNotEmpty)
            CcSecureProgressPasswordWidget(
              password: _passwordController.text,
            ),
          const SizedBox(height: 40.0),
          CcTextFormFieldPasswordWidget(
            controller: _confirmPasswordController,
            label: "Confirmar contraseña",
            hint: "Confirma tu contraseña",
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Confirma tu contraseña";
              }

              if (value != _passwordController.text) {
                return "Las contraseñas no coinciden";
              }

              return null;
            },
          ),
          const SizedBox(height: 48.0),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CcButtonWidget(
                buttonType: ButtonType.elevated,
                label: "Cambiar contraseña",
                suffixIcon: const Icon(Icons.chevron_right),
                isLoading: false,
                onPressed: () {
                  if (_formKey.currentState!.validate()) {}
                },
              ),
              const SizedBox(height: 8.0),
              CcButtonWidget(
                buttonType: ButtonType.text,
                label: "No recibí el código",
                isLoading: false,
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}
