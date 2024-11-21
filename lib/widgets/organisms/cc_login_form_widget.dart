import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_clean_check/core/theme/themes.dart';
import 'package:mobile_clean_check/data/cubits/cubits.dart';
import 'package:mobile_clean_check/widgets/widgets.dart';
import 'package:mobile_clean_check/data/models/models.dart';

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
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthAuthenticated) {
          Navigator.pushNamedAndRemoveUntil(
            context,
            "/home",
                (route) => false,
          );
        } else if (state is AuthError) {
          CcSnackBarWidget.show(
            context,
            message: state.message,
            snackBarType: SnackBarType.error,
          );
        }
      },
      builder: (context, state) {
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

                  if (!RegExp(r'^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$')
                      .hasMatch(value)) {
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
              CcButtonWidget(
                buttonType: ButtonType.elevated,
                label: "Iniciar sesión",
                prefixIcon: const Icon(Icons.login_outlined),
                isLoading: state is AuthLoading,
                onPressed: _login,
              ),
              const SizedBox(height: 8.0),
              CcButtonWidget(
                buttonType: ButtonType.text,
                label: "¿Olvidaste tu contraseña?",
                isLoading: false,
                onPressed: () =>
                    Navigator.pushNamed(context, "/forgot-password"),
              ),
            ],
          ),
        );
      },
    );
  }

  void _login() {
    if (_formKey.currentState!.validate()) {
      final auth = AuthModel(
        email: _emailController.text,
        password: _passwordController.text,
      );
      context.read<AuthCubit>().login(auth);
    }
  }
}
