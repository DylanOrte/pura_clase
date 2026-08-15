import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pura_clase/assets/colores.dart';
import 'package:pura_clase/componentes/admin_llaves.dart';
import 'package:pura_clase/componentes/admin_pabellones.dart';
import 'package:pura_clase/componentes/modelos.dart';
import 'package:pura_clase/componentes/toast.dart';

class Administracion extends StatefulWidget {
  const Administracion({super.key});

  @override
  State<Administracion> createState() => _AdministracionState();
}

class _AdministracionState extends State<Administracion> {

   void initState() {
    super.initState();
    conexionBD();
  }

  List<Pabellon> pabellones = [];
  List<LlaveData> llaves = [];
  bool cargando = true;
  void conexionBD() async {
    final uri = Uri.parse("https://api-pura-clase.onrender.com/api/api.php");

    try {
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final decoded = jsonDecode(response.body);
        final llavesJson = decoded['llaves'] as List<dynamic>;
        final pabellonesJson = decoded['pabellones'] as List<dynamic>;

        final todasLasLlaves = llavesJson
            .map((l) => LlaveData.fromJson(l as Map<String, dynamic>))
            .toList();
        final nuevosPabellones = pabellonesJson
            .map((p) => Pabellon.fromJson(p as Map<String, dynamic>))
            .toList();
        Toast.show(context, response.body);
        setState(() {
          pabellones = nuevosPabellones;
          llaves = todasLasLlaves;
          cargando = false;
        });
      } else {
        setState(() => cargando = false);
        if (mounted) {
          Toast.show(context, 'Error del servidor: ${response.statusCode}');
        }
      }
    } catch (error) {
      setState(() => cargando = false);
      if (mounted) {
        Toast.show(context, 'Error de conexión: Verifica tu servidor local');
        print("Error detallado: $error");
      }
    }
  }

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
            children: [AdminLlaves(llaves: llaves,)],
          ),
          SizedBox(height: 10),
          Center(child: AdminPabellones(pabellones: pabellones,)),
        ],
      ),
    );
  }
}