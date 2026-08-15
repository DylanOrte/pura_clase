import 'package:flutter/material.dart';
import 'package:pura_clase/assets/colores.dart';

class AdminPabellones extends StatefulWidget {
  final pabellones;
  const AdminPabellones({super.key, required this.pabellones});

  @override
  State<AdminPabellones> createState() => _AdminPabellonesState();
}

class _AdminPabellonesState extends State<AdminPabellones> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      width: 385,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colores.panelBg,
        border: Border.all(color: Colores.borde, width: 1),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20, left: 15),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.apartment_outlined,
                  color: Colores.secundario,
                  size: 30,
                ),
                SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Pabellones",
                      style: TextStyle(fontSize: 15, color: Colores.textos),
                    ),
                    Text(
                      "Agrega o elimina pabellones",
                      style: TextStyle(fontSize: 12, color: Colores.textos2),
                    ),
                  ],
                ),
                SizedBox(width: 15),
                InkWell(
                  onTap: () {
                    print(widget.pabellones);
                  },
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
        ],
      ),
    );
  }
}
