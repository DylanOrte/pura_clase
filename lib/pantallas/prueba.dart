import 'package:flutter/material.dart';
import 'package:pura_clase/assets/colores.dart';
import 'package:qr_flutter/qr_flutter.dart';

class Prueba extends StatefulWidget {
  final String respuesta;
  const Prueba({super.key, required this.respuesta});

  @override
  State<Prueba> createState() => _PruebaState();
}

class _PruebaState extends State<Prueba> {
  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              QrImageView(
                data: widget.respuesta,
                version: QrVersions.auto,
                size: 300.0,
              ),
            ],
          ),
        ],
      );
  }
}
