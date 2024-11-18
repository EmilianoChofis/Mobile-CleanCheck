import 'package:flutter/material.dart';
import 'package:mobile_clean_check/widgets/widgets.dart';

class MaidHomeScreen extends StatelessWidget {
  const MaidHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CcAppBarWidget(title: "Inicio"),
      body: SingleChildScrollView(
        child: CcHomeTemplate(
          actions: Padding(
            padding: EdgeInsets.symmetric(vertical: 16.0),
            child: CcWorkingZoneTemplate(
                title: "Zonas de trabajo", actions: CcWorkingZoneMaidWidget()),
          ),
          content: CcListItemsWidget(
            title: 'Lista de Edificios',
            content: [
              {
                'name': 'Edificio Palmira',
                'rooms': '20 habitaciones',
              },
              {
                'name': 'Edificio Ciprés',
                'rooms': '15 habitaciones',
              },
              {
                'name': 'Edificio Palmira',
                'rooms': '20 habitaciones',
              },
              {
                'name': 'Edificio Ciprés',
                'rooms': '15 habitaciones',
              },
              {
                'name': 'Edificio Palmira',
                'rooms': '20 habitaciones',
              },
              {
                'name': 'Edificio Ciprés',
                'rooms': '15 habitaciones',
              },
            ],
          ),
        ),
      ),
    );
  }
}
