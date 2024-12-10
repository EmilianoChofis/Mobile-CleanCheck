import 'package:flutter/material.dart';
import 'package:mobile_clean_check/modules/auth/login_screen.dart';
import 'package:mobile_clean_check/navigation/navigation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RoleResolver extends StatelessWidget {
  const RoleResolver({super.key});

  Future<String?> _getRole() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('role');
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String?>(
      future: _getRole(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        } else if (snapshot.hasData && snapshot.data != null) {
          return BottomNavigation(role: snapshot.data!);
        } else {
          return const LoginScreen();
        }
      },
    );
  }
}