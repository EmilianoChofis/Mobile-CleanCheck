import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mobile_clean_check/core/theme/color_schemes.dart';
import 'package:mobile_clean_check/widgets/widgets.dart';

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
    Future.delayed(const Duration(seconds: 2), () async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final role = prefs.getString('role');
      final token = prefs.getString('token');

      if (mounted) {
        if (token != null && role != null) {
          Navigator.pushNamed(context, '/home');
        } else {
          Navigator.pushNamed(context, '/login');
        }
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
              const CcLogoWidget(),
              const SizedBox(height: 32.0),
              LinearProgressIndicator(color: surfaceColor),
            ],
          ),
        ),
      ),
    );
  }
}
