import 'package:flutter/material.dart';
import 'package:mobile_clean_check/core/theme/color_schemes.dart';
import 'package:mobile_clean_check/navigation/get_navigation_config.dart';

class BottomNavigation extends StatefulWidget {
  final String role;

  const BottomNavigation({
    required this.role,
    super.key,
  });

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int _selectedIndex = 0;

  late List<Widget> screenOptions;
  late List<BottomNavigationBarItem> items;
  late bool error;

  @override
  void initState() {
    super.initState();
    final config = getNavigationConfig(widget.role);
    error = config['error'];
    screenOptions = config['screens'];
    if (!error) {
      items = config['items'];
    }
  }

  @override
  Widget build(BuildContext context) {
    if (error) {
      return screenOptions[0];
    }

    return Scaffold(
      body: screenOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: items,
        currentIndex: _selectedIndex,
        selectedItemColor: ColorSchemes.primary,
        unselectedItemColor: ColorSchemes.secondary,
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w500),
        selectedFontSize: 12.0,
        onTap: _onItemTapped,
      ),
    );
  }

  void _onItemTapped(int index) => setState(() => _selectedIndex = index);
}
