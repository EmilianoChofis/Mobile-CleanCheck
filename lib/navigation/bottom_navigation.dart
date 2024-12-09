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

  late final List<GlobalKey<NavigatorState>> navigatorKeys;

  @override
  void initState() {
    super.initState();
    final config = getNavigationConfig(widget.role);
    error = config['error'];
    screenOptions = config['screens'];
    if (!error) {
      items = config['items'];
      navigatorKeys = List.generate(
        items.length,
        (_) => GlobalKey<NavigatorState>(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (error) {
      return screenOptions[0];
    }

    return PopScope(
      child: Scaffold(
        body: Stack(
          children: List.generate(
            screenOptions.length,
            (index) => Offstage(
              offstage: _selectedIndex != index,
              child: Navigator(
                key: navigatorKeys[index],
                onGenerateRoute: (RouteSettings settings) {
                  return MaterialPageRoute(
                    builder: (_) => screenOptions[index],
                  );
                },
              ),
            ),
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: items,
          currentIndex: _selectedIndex,
          selectedItemColor: ColorSchemes.primary,
          unselectedItemColor: ColorSchemes.secondary,
          selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w500),
          selectedFontSize: 12.0,
          onTap: _onItemTapped,
        ),
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      navigatorKeys[_selectedIndex]
          .currentState
          ?.popUntil((route) => route.isFirst);
      _selectedIndex = index;
    });
  }
}
