import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeTemplate extends StatefulWidget {
  final Widget actions;
  final Widget content;

  const HomeTemplate({required this.actions, required this.content, super.key});

  @override
  State<HomeTemplate> createState() => _HomeTemplateState();
}

class _HomeTemplateState extends State<HomeTemplate> {
  String? userName;

  @override
  void initState() {
    super.initState();
    _getUserName();
  }

  Future<void> _getUserName() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() => userName = prefs.getString('user') ?? 'Usuario');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: const BoxDecoration(
        color: Colors.blue, // Azul de fondo
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20.0), // Esquina inferior izquierda redondeada
          bottomRight: Radius.circular(20.0), // Esquina inferior derecha redondeada
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Text('Hola ${userName!}, '),
              const Text(
                '¿Qué quieres hacer hoy?',
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
            ],
          ),
          widget.content, // Renderiza el contenido
          widget.actions, // Renderiza las acciones
        ],
      ),
    );
  }
}
