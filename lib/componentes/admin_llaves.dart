import 'package:flutter/material.dart';
import 'package:pura_clase/assets/colores.dart';

class AdminLlaves extends StatefulWidget {
  const AdminLlaves({super.key});

  @override
  State<AdminLlaves> createState() => _AdminLlavesState();
}

class _AdminLlavesState extends State<AdminLlaves> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 450,
      width: 375,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colores.panelBg,
        border: Border.all(color: Colores.borde, width: 1),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20, left: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.vpn_key_outlined,
                  color: Colores.secundario,
                  size: 30,
                ),
                SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Llaves",
                      style: TextStyle(fontSize: 15, color: Colores.textos),
                    ),
                    Text(
                      "Administra las llaves disponibles",
                      style: TextStyle(fontSize: 12, color: Colores.textos2),
                    ),
                  ],
                ),
                SizedBox(width: 10),
                InkWell(
                  child: Container(
                    height: 34,
                    width: 120,
                    decoration: BoxDecoration(
                      color: Colores.secundario.withAlpha(20),
                      border: Border.all(
                        width: 1,
                        color: Colores.secundario.withAlpha(40),
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Icon(Icons.add, color: Colores.secundario, size: 20),
                        Text(
                          "Añadir llave",
                          style: TextStyle(
                            color: Colores.secundario,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 250,
            width: 325,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: Colores.panelBg,
              border: Border.all(color: Colores.borde, width: 1),
            ),
          ),
        ],
      ),
    );
  }
}
