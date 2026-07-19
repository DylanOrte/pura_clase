import 'package:flutter/material.dart';
import 'package:pura_clase/diseños/colores.dart';
class Texto_Is extends StatefulWidget {
  String texto = "Texto";
  Texto_Is({super.key, required this.texto});

  @override
  State<Texto_Is> createState() => _TextoIsState();
}

class _TextoIsState extends State<Texto_Is> {
  @override
  Widget build(BuildContext context) {
    return Text(
      widget.texto,
      style: TextStyle(fontSize: 20, color: Colores.textos),
    );
  }
}
