import 'package:flutter/material.dart';
import 'package:mobile_clean_check/core/theme/themes.dart';
import 'package:mobile_clean_check/widgets/widgets.dart';

class CcForgotPasswordFormWidget extends StatefulWidget {
  const CcForgotPasswordFormWidget({super.key});

  @override
  State<CcForgotPasswordFormWidget> createState() =>
      _CcForgotPasswordFormWidgetState();
}

class _CcForgotPasswordFormWidgetState
    extends State<CcForgotPasswordFormWidget> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Recuperar contraseña",
            style: TextThemes.lightTextTheme.headlineSmall,
          ),
          const SizedBox(height: 24.0),
          Text(
            "Introduce el correo asociado a tu cuenta para recibir instrucciones de recuperación.",
            style: TextThemes.lightTextTheme.bodyLarge,
          ),
          const SizedBox(height: 40.0),
          CcTextFormFieldWidget(
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            label: "Correo electrónico",
            hint: "Ingresa tu correo electrónico",
            icon: const Icon(Icons.email_outlined),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Ingresa tu correo electrónico";
              }

              if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                  .hasMatch(value)) {
                return "Ingresa un correo electrónico válido";
              }

              return null;
            },
          ),
          const SizedBox(height: 48.0),
          CcParamsButtonWidget(
            buttonType: ButtonType.elevated,
            label: "Enviar correo",
            suffixIcon: const Icon(Icons.chevron_right),
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                Navigator.pushNamed(context, '/change-password');
              }
            },
          ),
          const SizedBox(height: 8.0),
          CcParamsButtonWidget(
            buttonType: ButtonType.text,
            label: "Iniciar sesión",
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }
}
