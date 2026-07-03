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
          child: Text("Llaves", style: TextStyle(color: Colores.letra, fontSize: 40)),
        ),
        Text("Pabellón 1: ", style: TextStyle(color: Colors.black, fontSize: 20),),
        SizedBox(height: 30,),
        Row(
          children: [
            Spacer(),
            Llave(numLlave: "1", profesor: "Johan Granados",),
            Spacer(),
            Llave(numLlave: "2", profesor: "Fernely Artavia",),
            Spacer()
          ],
        )
      ],
    );
  }
}
