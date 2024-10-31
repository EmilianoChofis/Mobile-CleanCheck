import 'package:flutter/material.dart';
import 'package:mobile_clean_check/core/theme/color_schemes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final primaryColor = ColorSchemes.primary;
  final surfaceColor = ColorSchemes.white;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        Navigator.pushReplacementNamed(context, '/login');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(64.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // Logo con color blanco
              Image.asset(
                'assets/images/logo.png',
                color: surfaceColor,
              ),
              const SizedBox(height: 32.0),
              LinearProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(surfaceColor),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
