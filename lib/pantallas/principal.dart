import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pura_clase/componentes/llave.dart';
import 'package:pura_clase/assets/colores.dart';
import 'package:pura_clase/componentes/toast.dart';

class Principal extends StatefulWidget {
  const Principal({super.key});

  @override
  State<Principal> createState() => _MyWidgetState();
}

class Pabellon {
  final String nombre;
  final List<String> llaves;
  Pabellon({required this.nombre, required this.llaves});
}

class _MyWidgetState extends State<Principal> {
  void conexionBD() async {
    String url = "https://api-pura-clase.onrender.com/api/api.php";

    try {
      http.Response respuesta = await http.get(
        Uri.parse(url),
      );
      if (respuesta.statusCode == 200) {
        setState(() {
          Toast.show(context, respuesta.body);
          }
        );
      } else {
        setState(() {
          Toast.show(context, "No fue posible conectarse");
        });
      }
    } catch (error) {
      setState(() {
        Toast.show(context, "Error");
      });
    }
  }
  final List<Pabellon> pabellones = [
    Pabellon(
      nombre: "Pabellón 1",
      llaves: ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11"],
    ),
    /*
    Pabellon(
      nombre: "Pabellón 2",
      llaves: [
        "12",
        "13",
        "14",
        "15",
        "16",
        "17",
        "18",
        "19",
        "20",
        "21",
        "22",
        "23",
      ],
    ),
    Pabellon(
      nombre: "Pabellón 3",
      llaves: [
        "24",
        "25",
        "26",
        "27",
        "28",
        "29",
        "30",
        "31",
        "32",
        "33",
        "34",
        "35",
      ],
    ),
    Pabellon(
      nombre: "Ambientales",
      llaves: ["36", "37", "39", "40", "41", "42"],
    ),
    Pabellon(nombre: "Salones", llaves: ["1", "2", "3", "4"]),
  */
  ];

  int? indiceAbierto;

  @override
  Widget build(BuildContext context) {
    conexionBD();
    return Scaffold(
      backgroundColor: Colores.fondo,
      body: SafeArea(
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            children: [
              Container(
                height: 120,
                width: double.infinity,
                alignment: Alignment.center,
                child: Text(
                  "Llaves",
                  style: TextStyle(
                    color: Colores.textos,
                    fontSize: 44,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
      
              for (int i = 0; i < pabellones.length; i++) _buildPabellon(i),
            ],
          ),
        ),
    );
  }

  Widget _buildPabellon(int i) {
    final pabellon = pabellones[i];
    final abierto = indiceAbierto == i;

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        border: Border.all(color: Colores.borde, width: 0.5),
        borderRadius: BorderRadius.circular(10),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          InkWell(
            onTap: () {
              setState(() {
                indiceAbierto = abierto ? null : i;
              });
            },
            child: Container(
              width: double.infinity,
              color: Colores.panelBg,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    pabellon.nombre,
                    style: TextStyle(
                      color: Colores.textos,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Icon(
                    abierto
                        ? Icons.keyboard_arrow_up
                        : Icons.keyboard_arrow_down,
                    color: Colores.muted,
                  ),
                ],
              ),
            ),
          ),
          AnimatedCrossFade(
            firstChild: const SizedBox(width: double.infinity, height: 0),
            secondChild: Padding(
              padding: const EdgeInsets.fromLTRB(16, 14, 16, 14),
              child: Column(
                children: [
                  for (int j = 0; j < pabellon.llaves.length; j++) ...[
                    Llave(numLlave: pabellon.llaves[j]),
                    if (j != pabellon.llaves.length - 1)
                      const SizedBox(height: 14),
                  ],
                ],
              ),
            ),
            crossFadeState: abierto
                ? CrossFadeState.showSecond
                : CrossFadeState.showFirst,
            duration: const Duration(milliseconds: 200),
          ),
        ],
      ),
    );
  }
}
