import 'package:flutter/material.dart';
import 'package:pura_clase/diseños/colores.dart';

class Llave extends StatefulWidget {
  final String numLlave;
  final String profesor;
  const Llave({super.key, required this.numLlave, required this.profesor});

  @override
  State<Llave> createState() => _LlaveState();
}

class _LlaveState extends State<Llave> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      height: 100,
      color: Colores.fondo2,
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                widget.numLlave,
                style: TextStyle(color: Colores.letra, fontSize: 25),
                textAlign: TextAlign.center,
              ),
              Text(widget.profesor, style: TextStyle(color: Colors.black)),
            ],
          ),
          Positioned.fill(
            child: GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text(widget.numLlave),
                      content: TextField(),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text("Cerrar"),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
