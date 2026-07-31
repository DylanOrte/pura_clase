import 'package:flutter/material.dart';
import 'package:pura_clase/assets/colores.dart';
class EntradaDeTextoIs extends StatefulWidget {
  final String pista;
  final TextEditingController controlador;
  final bool contrasena;
  final int caracteresMax;
  EntradaDeTextoIs({super.key, required this.pista, required this.controlador, required this.contrasena, required this.caracteresMax});

  @override
  State<EntradaDeTextoIs> createState() => _EntradaDeTextoIsState();
}
class _EntradaDeTextoIsState extends State<EntradaDeTextoIs> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        obscureText: widget.contrasena,
        controller: widget.controlador,
        cursorColor: Colores.textos2,
        maxLength: widget.caracteresMax,
        style: TextStyle(color: Colores.textos2),
        decoration: InputDecoration(
          counterStyle: TextStyle(color: Colores.textos2), 
          hintStyle: TextStyle(color: Colores.textos2),
          filled: true,
          fillColor: Colores.fondo,
          hintText: widget.pista,
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(8),
          ),
        ), 
      ),
    );
  }
}
