import 'package:flutter/material.dart';
import 'package:pura_clase/assets/colores.dart';

class Ventanaemerg extends StatefulWidget {
  const Ventanaemerg({super.key});

  @override
  State<Ventanaemerg> createState() => _VentanaemergState();
}

class _VentanaemergState extends State<Ventanaemerg> {
  final List<String> pabellones = [];
  String? pabellonSeleccionado; 
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.zero,
      constraints: BoxConstraints(maxWidth: 325),
      backgroundColor: Colors.transparent,
      content: Container(
        height: 420,
        width: 325,
        decoration: BoxDecoration(
          color: Colores.panelBg,
          border: Border.all(width: 1, color: Colores.borde),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 65,
              width: 65,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colores.secundario.withAlpha(25),
              ),
              child: Icon(
                Icons.vpn_key_outlined,
                color: Colores.secundario,
                size: 40,
              ),
            ),
            SizedBox(height: 10),
            Text(
              "Añadir llave",
              style: TextStyle(color: Colores.textos, fontSize: 20),
            ),
            Text(
              "Complete la informacion para añadir una nueva llave",
              style: TextStyle(color: Colores.textos2, fontSize: 15),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            SizedBox(
              height: 50,
              width: 300,
              child: TextField(
                decoration: InputDecoration(
                  labelText: "Numero de llave",
                  labelStyle: TextStyle(color: Colores.secundario),
                  prefixIcon: Icon(
                    Icons.vpn_key_outlined,
                    color: Colores.secundario,
                  ),
                  fillColor: Colores.panelBg,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide(
                      color: Colores.secundario,
                      width: 0.7,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide(
                      color: Colores.secundario,
                      width: 0.7,
                    ),
                  ),
                ),
                style: TextStyle(color: Colores.textos2),
              ),
            ),
            SizedBox(height: 20),
            DropdownMenu<String>(
              dropdownMenuEntries: pabellones.map((pabellon) {
                return DropdownMenuEntry<String>(value: pabellon, label: pabellon);
              }).toList(),
              width: 300,
              initialSelection: pabellonSeleccionado,
              hintText: 'Seleccione un pabellon',
              leadingIcon: Icon(Icons.apartment_outlined, color: Colores.secundario,),
              trailingIcon: Icon(Icons.keyboard_arrow_down_rounded, color: Colores.secundario,),
              selectedTrailingIcon: Icon(Icons.keyboard_arrow_up_rounded, color: Colores.secundario,),
              textStyle: TextStyle(color: Colores.textos),
              menuStyle: MenuStyle(backgroundColor: WidgetStatePropertyAll(Colores.fondo), shape: WidgetStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadiusGeometry.circular(16)))),
              inputDecorationTheme: InputDecorationTheme(filled: true,fillColor: Colores.panelBg,hintStyle: TextStyle(color: Colores.secundario), 
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16), borderSide: BorderSide(color: Colores.secundario)),
                enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide(color: Colores.secundario)),
                focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide(color: Colores.secundario),),),
              onSelected: (value) {
                setState(() {
                  pabellonSeleccionado = value;
                });
              },
            ),
            SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  height: 40,
                  width: 135,
                  decoration: BoxDecoration(color: Colores.panelBg, border: Border.all(width: 0.7, color: Colores.secundario), borderRadius: BorderRadius.circular(8)),
                  child: Center(child: Text("Cancelar", style: TextStyle(color: Colores.secundario),)),
                ),
                Container(
                  height: 40,
                  width: 135,
                  decoration: BoxDecoration(color: Colores.secundario, border: Border.all(width: 0.7, color: Colores.secundario), borderRadius: BorderRadius.circular(8)),
                  child: Center(child: Text("Añadir", style: TextStyle(color: Colores.textos),)),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
