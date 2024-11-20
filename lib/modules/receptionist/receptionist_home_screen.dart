import 'package:flutter/material.dart';
import 'package:mobile_clean_check/widgets/widgets.dart';

class ReceptionistHomeScreen extends StatelessWidget {
  const ReceptionistHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CcAppBarWidget(title: "Inicio"),
      body: Center(
        child: Text("Recepcionist Home Screen"),
      ),
    );
  }
}
