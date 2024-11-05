import 'package:flutter/material.dart';
import 'package:mobile_clean_check/core/theme/app_theme.dart';
import 'package:mobile_clean_check/navigation/navigations.dart';
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
        //auth routes
        '/': (context) => const SplashScreen(),
        '/login': (context) => const LoginScreen(),
        '/forgot-password': (context) => const ForgotPasswordScreen(),
        '/change-password': (context) => const ChangePasswordScreen(),

        //user routes
        '/home': (context) => const BottomNavigation(role: 'maid'),

        //maid routes

        //receptionist routes


        //manager routes


      },
    );
  }
}
