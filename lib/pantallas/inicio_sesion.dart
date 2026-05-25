import 'dart:ffi';
import 'package:pura_clase/nucleo/colores.dart';
import 'package:flutter/material.dart';

class InicioSesion extends StatefulWidget {
  const InicioSesion({super.key});

  @override
  State<InicioSesion> createState() => _InicioSesionState();
}

class _InicioSesionState extends State<InicioSesion> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Spacer(),
          Text(
            "PuraClase",
            style: TextStyle(
              fontSize: 30,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            "Crea tu cuenta para comenzar",
            style: TextStyle(fontSize: 20, color: Colores.letra),
          ),
          Spacer(),
          Container(
            height: 500,
            width: 300,
            color: Colores.primario,
            child: Padding(
              padding: const EdgeInsets.only(top: 25, left: 25),
              child: Column(
                children: [
                  Text(
                    "Nombre",
                    style: TextStyle(fontSize: 20, color: Colores.letra),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(decoration: InputDecoration(hintText: "Ingrese su nombre", border: OutlineInputBorder()),),
                  )
                ],
              ),
            ),
          ),
          Spacer(),
        ],
      ),
    );
  }
}
