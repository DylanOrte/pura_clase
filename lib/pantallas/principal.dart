import 'package:flutter/material.dart';
import 'package:pura_clase/componentes/llave.dart';
import 'package:pura_clase/diseños/colores.dart';

class Principal extends StatefulWidget {
  const Principal({super.key});

  @override
  State<Principal> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<Principal> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 150,
          width: double.infinity,
          alignment: Alignment.center,
          child: Text("Llaves", style: TextStyle(color: Colores.textos, fontSize: 50, fontWeight:  FontWeight(700))),
        ),
        Text("Pabellón 1: ", style: TextStyle(color: Colors.black, fontSize: 25, fontWeight: FontWeight(500)),),
        SizedBox(height: 30,),
        Row(
          children: [
            Spacer(),
            Llave(numLlave: "1"),
            Spacer(),
            Llave(numLlave: "2"),
            Spacer()
          ],
        ),
        Spacer(),
        Row(
          children: [
            Spacer(),
            Llave(numLlave: "3"),
            Spacer(),
            Llave(numLlave: "4"),
            Spacer()
          ],
        ),
        Spacer(),
        Row(
          children: [
            Spacer(),
            Llave(numLlave: "5"),
            Spacer(),
            Llave(numLlave: "6"),
            Spacer()
          ],
        ),
        Spacer(),
        Row(
          children: [
            Spacer(),
            Llave(numLlave: "7"),
            Spacer(),
            Llave(numLlave: "8"),
            Spacer()
          ],
        ),
        Spacer()
      ],
    );
  }
}
