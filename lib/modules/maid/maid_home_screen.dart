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
          header: CcWelcomeHomeTemplate(
            actions: CcWorkingZoneTemplate(
                title: "Zonas de trabajo", actions: CcWorkingZoneMaidWidget()),
          ),
          content: CcTitleContentTemplate(
            title: 'Lista de edificios',
            content: CcListItemsWidget(
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
      ),
    );
  }
}
