import 'package:flutter/material.dart';

class EntradaDeTextoIs extends StatefulWidget {
  final String pista;
  final TextEditingController controlador;
  final bool contrasena;
  EntradaDeTextoIs({super.key, required this.pista, required this.controlador, required this.contrasena});

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
        decoration: InputDecoration(
          hintText: widget.pista,
          border: OutlineInputBorder(),
        ),
      ),
    );
  }
}
