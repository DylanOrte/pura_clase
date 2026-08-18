import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pura_clase/assets/colores.dart';
import 'package:http/http.dart' as http;
import 'package:pura_clase/componentes/toast.dart';

class AdminLlave extends StatefulWidget {
  final llave;
  const AdminLlave({super.key, required this.llave});

  @override
  State<AdminLlave> createState() => _AdminLlaveState();
}

class _AdminLlaveState extends State<AdminLlave> {

  void eliminarLlave() async {
    final uri = Uri.parse("https://api-pura-clase.onrender.com/api/api.php");

    final Map<String, dynamic> body = {
      'accion': 'eliminarLlave',
      'llave': widget.llave.numero
    };

    try {
      final response = await http.delete(
        uri,
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
        body: jsonEncode(body),
      );

      if (response.statusCode == 200) {
        Toast.show(context, response.body);
      } else {
        Toast.show(context, response.body);
      }
    } catch (error) {
      Toast.show(context, error.toString());
    }
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      decoration: BoxDecoration(
        color: widget.llave.estado == 0 ? Colores.fondo.withAlpha(25) : Colores.rojoOscuro.withAlpha(35),
        border: Border.symmetric(
          horizontal: BorderSide(width: 1, color: Colores.borde),
        ),
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 13),
            child: Container(
              height: 45,
              width: 45,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: widget.llave.estado == 0 ? Colores.secundario.withAlpha(20) : Colores.rojo.withAlpha(20),
              ),
              child: Icon(Icons.vpn_key_outlined, color: widget.llave.estado == 0 ? Colores.secundario : Colores.rojo),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Llave ${widget.llave.numero}",
                style: TextStyle(color: Colores.textos, fontSize: 17),
              ),
              Text(
                "Pabellon ${widget.llave.pabellon}",
                style: TextStyle(color: Colores.textos2, fontSize: 13),
              ),
            ],
          ),
          Spacer(),
          Container(
            height: 30,
            width: 80,
            decoration: BoxDecoration(
              color: widget.llave.estado == 0 ? Colores.secundario.withAlpha(20) : Colores.rojo.withAlpha(20),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Center(
              child: Text(
                widget.llave.estado == 0 ? "Disponible" : "Ocupada",
                style: TextStyle(color: widget.llave.estado == 0 ? Colores.secundario : Colores.rojo, fontSize: 13),
              ),
            ),
          ),
          SizedBox(width: 15),
          InkWell(
            onTap:() {
              if (widget.llave.estado == 0) {
                eliminarLlave();
              } else {
                Toast.show(context, "No se pueden eliminar llaves ocupadas");
              }
            },
            child: Icon(Icons.delete_outlined, color: Colores.rojo, size: 30)),
          
          SizedBox(width: 20),
        ],
      ),
    
    );
  }
}
