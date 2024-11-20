import 'package:flutter/material.dart';
import 'package:mobile_clean_check/widgets/widgets.dart';

class ManagerHomeScreen extends StatelessWidget {
  const ManagerHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CcAppBarWidget(title: "Inicio"),
      body: CcHeaderTemplate(
        header: Padding(
          padding: EdgeInsets.symmetric(vertical: 16.0),
          child: Text("Replace this with the actions widget",
              style: TextStyle(color: Colors.white)),
        ),
        content: Text("Replace this with the content widget"),
      ),
    );
  }
}
