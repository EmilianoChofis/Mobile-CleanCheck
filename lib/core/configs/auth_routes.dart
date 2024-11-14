import 'package:flutter/material.dart';
import 'package:mobile_clean_check/navigation/navigation.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<String?> getRole() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString('role') ?? 'Maid';
}

Widget buildRoute(Widget screen, Future<String?> roleFuture) {
  return FutureBuilder<String?>(
    future: roleFuture,
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return const Center(child: CircularProgressIndicator());
      } else if (snapshot.hasData && snapshot.data != null) {
        return BottomNavigation(role: snapshot.data!);
      } else {
        return screen;
      }
    },
  );
}
