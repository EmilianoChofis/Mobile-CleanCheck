import 'package:flutter/material.dart';
import 'package:mobile_clean_check/widgets/widgets.dart';

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CcAppBarWidget(title: "Algo salió mal"),
      body: Center(
        child: Text('No se pudo cargar la pantalla'),
      ),
    );
  }
}
