import 'package:flutter/material.dart';
import 'package:mobile_clean_check/modules/modules.dart';
import 'package:mobile_clean_check/navigation/error_screen.dart';
import 'package:mobile_clean_check/widgets/widgets.dart';

final Map<String, Map<String, dynamic>> roleConfigurations = {
  'Manager': {
    'error': false,
    'screens': const [
      ManagerHomeScreen(),
      ManagerBuildingsScreen(),
      ManagerUsersScreen(),
      IncidencesScreen(),
      ProfileScreen(),
    ],
    'items': [
      const BottomNavigationBarItem(
        label: 'Inicio',
        icon: Icon(Icons.home_outlined),
        activeIcon: CcBnbActiveIconWidget(icon: Icon(Icons.home_outlined)),
      ),
      const BottomNavigationBarItem(
        label: 'Edificios',
        icon: Icon(Icons.apartment_outlined),
        activeIcon: CcBnbActiveIconWidget(icon: Icon(Icons.apartment_outlined)),
      ),
      const BottomNavigationBarItem(
        label: 'Usuarios',
        icon: Icon(Icons.group_outlined),
        activeIcon: CcBnbActiveIconWidget(icon: Icon(Icons.group_outlined)),
      ),
      const BottomNavigationBarItem(
        label: 'Reportes',
        icon: Icon(Icons.warning_amber),
        activeIcon: CcBnbActiveIconWidget(icon: Icon(Icons.warning_amber)),
      ),
      const BottomNavigationBarItem(
        label: 'Perfil',
        icon: Icon(Icons.person_outline),
        activeIcon: CcBnbActiveIconWidget(icon: Icon(Icons.person_outline)),
      ),
    ],
  },
  'Receptionist': {
    'error': false,
    'screens': const [
      ReceptionistHomeScreen(),
      IncidencesScreen(),
      ProfileScreen(),
    ],
    'items': [
      const BottomNavigationBarItem(
        label: 'Inicio',
        icon: Icon(Icons.home_outlined),
        activeIcon: CcBnbActiveIconWidget(icon: Icon(Icons.home_outlined)),
      ),
      const BottomNavigationBarItem(
        label: 'Reportes',
        icon: Icon(Icons.warning_amber),
        activeIcon: CcBnbActiveIconWidget(icon: Icon(Icons.warning_amber)),
      ),
      const BottomNavigationBarItem(
        label: 'Perfil',
        icon: Icon(Icons.person_outline),
        activeIcon: CcBnbActiveIconWidget(icon: Icon(Icons.person_outline)),
      ),
    ],
  },
  'Maid': {
    'error': false,
    'screens': const [
      MaidHomeScreen(),
      IncidencesScreen(),
      ProfileScreen(),
    ],
    'items': [
      const BottomNavigationBarItem(
        label: 'Inicio',
        icon: Icon(Icons.home_outlined),
        activeIcon: CcBnbActiveIconWidget(icon: Icon(Icons.home_outlined)),
      ),
      const BottomNavigationBarItem(
        label: 'Reportes',
        icon: Icon(Icons.warning_amber),
        activeIcon: CcBnbActiveIconWidget(icon: Icon(Icons.warning_amber)),
      ),
      const BottomNavigationBarItem(
        label: 'Perfil',
        icon: Icon(Icons.person_outline),
        activeIcon: CcBnbActiveIconWidget(icon: Icon(Icons.person_outline)),
      ),
    ],
  },
};

Map<String, dynamic> getNavigationConfig(String role) {
  return roleConfigurations[role] ??
      {
        'screens': [const ErrorScreen()],
        'error': true,
      };
}
