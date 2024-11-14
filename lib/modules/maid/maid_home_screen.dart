import 'package:flutter/material.dart';
import 'package:mobile_clean_check/widgets/widgets.dart';

class MaidHomeScreen extends StatelessWidget {
  const MaidHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CcAppBarWidget(title: "Inicio"),
      body: HomeTemplate(
        actions: Text("data"),
        content: Text("data"),
      ),
    );
  }
}
