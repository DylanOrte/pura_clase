import 'package:pura_clase/componentes/admin_llave.dart';
import 'package:flutter/material.dart';
import 'package:pura_clase/assets/colores.dart';
import 'package:pura_clase/componentes/ventanaEmerg.dart';

class AdminLlaves extends StatefulWidget {
  final llaves;
  final pabellones;
  const AdminLlaves({super.key, required this.llaves, required this.pabellones});

  @override
  State<AdminLlaves> createState() => _AdminLlavesState();
}

class _AdminLlavesState extends State<AdminLlaves> {
  final controladorLlave = TextEditingController();
  final controladorPabellon = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 350,
      width: 385,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colores.panelBg,
        border: Border.all(color: Colores.borde, width: 1),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20, left: 25),
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
                      "Agrega o elimina llaves",
                      style: TextStyle(fontSize: 12, color: Colores.textos2),
                    ),
                  ],
                ),
                SizedBox(width: 50),
                InkWell(
                  onTap: () {
                    showDialog(context: context, builder:(context) {
                      return Ventanaemerg(controladorLlave: controladorLlave, pabellones: widget.pabellones);
                    },);
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
          SizedBox(height: 15),
          Container(
            height: 260,
            width: 360,
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: Colores.panelBg,
              border: Border.all(color: Colores.borde, width: 1),
            ),
            child: ListView(
              padding: EdgeInsets.symmetric(vertical: 0),
              children: [
                for (int i = 0; i < widget.llaves.length; i++)
                  AdminLlave(llave: widget.llaves[i]),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
