import 'package:flutter/material.dart';
import 'package:mobile_clean_check/core/configs/configs.dart';
import 'package:mobile_clean_check/core/theme/app_theme.dart';
import 'package:mobile_clean_check/navigation/navigation.dart';
import 'package:mobile_clean_check/modules/modules.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Mobile CleanCheck',
      theme: AppTheme.lightTheme,
      themeMode: ThemeMode.system,
      routes: {
        '/': (context) => const SplashScreen(),
        '/login': (context) => buildRoute(const LoginScreen(), getRole()),
        '/forgot-password': (context) => buildRoute(const ForgotPasswordScreen(), getRole()),
        '/change-password': (context) => buildRoute(const ChangePasswordScreen(), getRole()),
        '/home': (context) => _buildHomeRoute(),
      },
    );
  }

  Widget _buildHomeRoute() {
    return buildRoute(const LoginScreen(), getRole());
  }
}
