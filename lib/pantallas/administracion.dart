import 'package:flutter/material.dart';
import 'package:pura_clase/assets/colores.dart';
import 'package:pura_clase/componentes/admin_llaves.dart';

class Administracion extends StatefulWidget {
  const Administracion({super.key});

  @override
  State<Administracion> createState() => _AdministracionState();
}

class _AdministracionState extends State<Administracion> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colores.fondo,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 40, left: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Administración",
                  style: TextStyle(
                    fontSize: 30,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "Gestiona las llaves y pabellones",
                  style: TextStyle(fontSize: 15, color: Colores.textos2),
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AdminLlaves(),
            ],
          ),
        ],
      ),
    );
  }
}
