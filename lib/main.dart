import 'package:flutter/material.dart';
import 'package:pura_clase/pantallas/administracion.dart';
import 'package:pura_clase/pantallas/inicio_sesion.dart';
import 'package:pura_clase/assets/colores.dart';
import 'package:pura_clase/pantallas/principal.dart';
import 'package:pura_clase/pantallas/prueba.dart';
void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        backgroundColor: Colores.fondo,
        body: Principal()
      ),
    );
  }
}
