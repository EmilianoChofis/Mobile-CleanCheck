import 'package:flutter/material.dart';
import 'package:mobile_clean_check/core/theme/themes.dart';
import 'package:mobile_clean_check/widgets/widgets.dart';

class CcLoginFormWidget extends StatefulWidget {
  const CcLoginFormWidget({super.key});

  @override
  State<CcLoginFormWidget> createState() => _CcLoginFormWidgetState();
}

class _CcLoginFormWidgetState extends State<CcLoginFormWidget> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Iniciar sesión",
            style: TextThemes.lightTextTheme.headlineSmall,
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

              if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                return "Ingresa un correo electrónico válido";
              }

              return null;
            },
          ),
          const SizedBox(height: 40.0),
          CcTextFormFieldPasswordWidget(
            controller: _passwordController,
            label: "Contraseña",
            hint: "Ingresa tu contraseña",
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Ingresa tu contraseña";
              }
              return null;
            },
          ),
          const SizedBox(height: 48.0),
          CcParamsButtonWidget(
            buttonType: ButtonType.elevated,
            label: "Iniciar sesión",
            prefixIcon: const Icon(Icons.login_outlined),
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                //Logica de inicio de sesion
                Navigator.pushNamedAndRemoveUntil(context, "/home", (route) => false);
              }
            },
          ),
          const SizedBox(height: 8.0),
          CcParamsButtonWidget(
            buttonType: ButtonType.text,
            label: "¿Olvidaste tu contraseña?",
            onPressed: () {
              Navigator.pushNamed(context, "/forgot-password");
            },
          ),
        ],
      ),
    );
  }
}