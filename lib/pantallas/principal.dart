import 'dart:convert';
import 'package:pura_clase/componentes/modelos.dart';
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

class _MyWidgetState extends State<Principal> {
  List<Pabellon> pabellones = [];
  List<LlaveData> llaves = [];
  
  @override
  void initState() {
    super.initState();
    conexionBD();
  }

  bool cargando = true;
  void conexionBD() async {
    final uri = Uri.parse("http://10.0.2.2/api/api/api.php");
    
    try {
    final response = await http.get(uri);
    if (response.statusCode != 200) {
      Toast.show(context, 'Error en la petición: ${response.statusCode}');
    }
    setState(() {
      cargando = false;
      return;
    });

    final decoded = jsonDecode(response.body);
    final llavesJson = decoded['llaves'] as List<dynamic>;
    final pabellonesJson = decoded['pabellones'] as List<dynamic>;

    final todasLasLlaves = llavesJson
        .map((l) => LlaveData.fromJson(l as Map<String, dynamic>))
        .toList();
    final nuevosPabellones = pabellonesJson
        .map((p) => Pabellon.fromJson(p as Map<String, dynamic>))
        .toList();
    setState(() {
      pabellones = nuevosPabellones;
      llaves = todasLasLlaves;
      cargando = false;
    });
  } catch (error) {
    setState(() => cargando = false,);
    if (mounted) {
      Toast.show(context, error.toString());
      print(error.toString());
    }
    
  }
  }

  int? indiceAbierto;

  @override
  Widget build(BuildContext context) {
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
    final llave = llaves;
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
                    "Pabellon ${pabellon.id}",
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
                  for (int j = 0; j < llave.length; j++) ...[
                    if (llave[j].pabellon == pabellon.id)
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 6),
                        child: Llave(numLlave: llave[j].numero.toString()),
                      ),
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
