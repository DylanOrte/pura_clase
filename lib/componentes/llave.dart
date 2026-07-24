import 'package:flutter/material.dart';
import 'package:pura_clase/assets/colores.dart';

class Llave extends StatefulWidget {
  final String numLlave;
  const Llave({super.key, required this.numLlave});

  @override
  State<Llave> createState() => _LlaveState();
}

class _LlaveState extends State<Llave> {
  final TextEditingController _controller = TextEditingController();
  String profesor = "No tomada";
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: profesor == "No tomada" ? Colores.fondoClaro : Colores.primario,
      ),
      width: 150,
      height: 120,
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: double.infinity,
                child: Text(
                  widget.numLlave,
                  style: TextStyle(color: Colors.black, fontSize: 25),
                  textAlign: TextAlign.center,
                ),
              ),
              Text(profesor, style: TextStyle(color: Colors.black)),
            ],
          ),
          Positioned.fill(
            child: GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text("Ingrese el nombre del profesor que utilizara la llave: "),
                      content: TextField(
                        controller: _controller,
                        decoration: InputDecoration(hintText: "Nombre del profesor"),
                        maxLength: 20,
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            setState(() {
                              _controller.text != "" ? profesor = _controller.text : profesor = "No tomada";
                              _controller.text = "";
                            });
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
          Padding(
            padding: const EdgeInsets.only(top:65, left: 14),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colores.secundario,
                foregroundColor: Colores.fondoClaro
              ),
              onPressed: () {
              setState(() {
                profesor = "No tomada";
              });
            }, child: Text("Desasignar"),),
          )
        ],
      ),
    );
  }
}
