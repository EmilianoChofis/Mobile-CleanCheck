import 'package:flutter/material.dart';
import 'package:mobile_clean_check/widgets/widgets.dart';

class MaidBuildingScreen extends StatelessWidget {
  const MaidBuildingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CcAppBarWidget(
        title: "Registrar limpieza",
        actions: [
          IconButton(
            icon: const Icon(Icons.push_pin_outlined),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        // ignore: prefer_const_constructors
        child: CcHomeTemplate(
          header: Padding(
            padding: const EdgeInsets.all(8.0),
            child: CcItemListWidget(
              title: "Edificio Palmira",
              subtitle: const CcItemListBuildingContentWidget(room: 'P1H3'),
              icon: Icons.apartment,
              onTap: () {},
            ),
          ),
          content: const CcTitleContentTemplate(
            title: 'Habitaciones',
            content: CcMaidRoomsContentWidget(),
          ),
        ),
      ),
    );
  }
}
