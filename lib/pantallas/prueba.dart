import 'package:flutter/material.dart';

class Prueba extends StatefulWidget {
  final String respuesta;
  const Prueba({
    super.key,
    required this.respuesta
    });

  @override
  State<Prueba> createState() => _PruebaState();
}

class _PruebaState extends State<Prueba> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(widget.respuesta, style: TextStyle(color: Colors.white, fontSize: 20)),
    );
  }
}