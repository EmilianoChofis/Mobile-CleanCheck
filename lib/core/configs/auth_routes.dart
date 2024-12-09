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
=======
Future<String?> getRole() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString('role');
  // return 'Maid';
}