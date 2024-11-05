import 'package:flutter/material.dart';

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Algo salió mal'),
      ),
      body: const Center(
        child: Text('No se pudo cargar la pantalla'),
      ),
    );
  }
}
