import 'dart:convert';
import 'package:pura_clase/componentes/admin_llave.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart' as http;
import 'package:pura_clase/assets/colores.dart';
import 'package:pura_clase/componentes/modelos.dart';
import 'package:pura_clase/componentes/toast.dart';

class AdminLlaves extends StatefulWidget {
  final llaves;
  const AdminLlaves({super.key, required this.llaves});

  @override
  State<AdminLlaves> createState() => _AdminLlavesState();
}

class _AdminLlavesState extends State<AdminLlaves> {
  final controladorLlave = TextEditingController();
  final controladorPabellon = TextEditingController();

  void _anadirLlave() async {
    final uri = Uri.parse("http://10.0.2.2/api/api/api.php");

    final Map<String, String> body = {
      "accion": "anadirLlave",
      //"llave": widget.controladorLlave.text,
      // "pabellon": widget.controladorPabellon.text,
    };
    try {
      final response = await http.put(uri, body: body);

      if (response.statusCode == 200) {
        Toast.show(context, response.body);
      } else {
        Toast.show(context, response.statusCode.toString());
      }
    } catch (error) {
      Toast.show(context, error.toString());
    }
  }

  void _VentanaAnadirLlave() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          contentPadding: EdgeInsets.zero,
          constraints: BoxConstraints(maxWidth: 325),
          backgroundColor: Colors.transparent,
          content: Container(
            height: 450,
            width: 325,
            decoration: BoxDecoration(
              color: Colores.panelBg,
              border: Border.all(width: 1, color: Colores.borde),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 65,
                  width: 65,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colores.secundario.withAlpha(25),
                  ),
                  child: Icon(
                    Icons.vpn_key_outlined,
                    color: Colores.secundario,
                    size: 40,
                  ),
                ),
                SizedBox(height: 10),
                Text("Añadir llave", style: TextStyle(color: Colores.textos),)
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 385,
      width: 385,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colores.panelBg,
        border: Border.all(color: Colores.borde, width: 1),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20, left: 25),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.vpn_key_outlined,
                  color: Colores.secundario,
                  size: 30,
                ),
                SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Llaves",
                      style: TextStyle(fontSize: 15, color: Colores.textos),
                    ),
                    Text(
                      "Agrega o elimina llaves",
                      style: TextStyle(fontSize: 12, color: Colores.textos2),
                    ),
                  ],
                ),
                SizedBox(width: 50),
                InkWell(
                  onTap: () {
                    print(widget.llaves);
                    _VentanaAnadirLlave();
                  },
                  child: Container(
                    height: 34,
                    width: 120,
                    decoration: BoxDecoration(
                      color: Colores.secundario.withAlpha(20),
                      border: Border.all(
                        width: 1,
                        color: Colores.secundario.withAlpha(40),
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Icon(Icons.add, color: Colores.secundario, size: 20),
                        Text(
                          "Añadir llave",
                          style: TextStyle(
                            color: Colores.secundario,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 15),
          Container(
            height: 290,
            width: 360,
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: Colores.panelBg,
              border: Border.all(color: Colores.borde, width: 1),
            ),
            child: ListView(
              padding: EdgeInsets.symmetric(vertical: 0),
              children: [
                for (int i = 0; i < widget.llaves.length; i++)
                  AdminLlave(llave: widget.llaves[i]),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
