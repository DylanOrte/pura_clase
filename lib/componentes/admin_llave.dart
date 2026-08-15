import 'package:flutter/material.dart';
import 'package:pura_clase/assets/colores.dart';

class AdminLlave extends StatefulWidget {
  final llave;
  const AdminLlave({super.key, required this.llave});

  @override
  State<AdminLlave> createState() => _AdminLlaveState();
}

class _AdminLlaveState extends State<AdminLlave> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      decoration: BoxDecoration(
        color: Colores.fondo.withAlpha(25),
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
                color: Colores.secundario.withAlpha(20),
              ),
              child: Icon(Icons.vpn_key_outlined, color: Colores.secundario),
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
              color: Colores.secundario.withAlpha(20),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Center(
              child: Text(
                "Disponible",
                style: TextStyle(color: Colores.secundario, fontSize: 13),
              ),
            ),
          ),
          SizedBox(width: 15),
          InkWell(
            onTap:() {
              print(widget.llave);
            },
            child: Icon(Icons.delete_outlined, color: Colores.rojo, size: 30)),
          
          SizedBox(width: 20),
        ],
      ),
    
    );
  }
}
