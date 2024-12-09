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
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/login': (context) => const LoginScreen(),
        '/forgot-password': (context) => const ForgotPasswordScreen(),
        '/change-password': (context) => const ChangePasswordScreen(),
        '/home': (context) => const RoleResolver(),
      },
    );
  }
}
