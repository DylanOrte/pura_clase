import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pura_clase/assets/colores.dart';
import 'package:pura_clase/componentes/toast.dart';

class AdminPabellones extends StatefulWidget {
  final pabellones;
  const AdminPabellones({super.key, required this.pabellones});

  @override
  State<AdminPabellones> createState() => _AdminPabellonesState();
}

class _AdminPabellonesState extends State<AdminPabellones> {
  final controladorPabellon = TextEditingController();
  bool cargando = false;

  void anadirPabellon(BuildContext context) async {
    if (controladorPabellon.text.isEmpty) {
      Toast.show(context, "Por favor complete todos los campos");
      return;
    }

    setState(() => cargando = true);

    final Map<String, dynamic> body = {
      "accion": "anadirPabellon",
      "pabellon": controladorPabellon.text,
    };

    try {
      final response = await http.post(
        Uri.parse("https://api-pura-clase.onrender.com/api/api.php"),
        body: jsonEncode(body),
      );

      if (response.statusCode == 200) {
        Toast.show(context, "Pabellón añadido con éxito");
        controladorPabellon.clear();
        Navigator.pop(context);
      } else {
        Toast.show(context, "Error: ${response.body}");
      }
    } catch (error) {
      Toast.show(context, "Error de conexión");
    } finally {
      setState(() => cargando = false);
    }
  }

  void _mostrarDialogoAnadir(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: EdgeInsets.zero,
          constraints: const BoxConstraints(maxWidth: 325),
          backgroundColor: Colors.transparent,
          content: Container(
            height: 350,
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
                    Icons.apartment_outlined,
                    color: Colores.secundario,
                    size: 40,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  "Añadir Pabellón",
                  style: TextStyle(color: Colores.textos, fontSize: 20),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    "Ingrese el número de pabellón",
                    style: TextStyle(color: Colores.textos2, fontSize: 14),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 25),
                _buildTextField(
                  controlador: controladorPabellon,
                  label: "Número de Pabellón",
                  icon: Icons.apartment_outlined,
                ),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        height: 40,
                        width: 130,
                        decoration: BoxDecoration(
                          color: Colores.panelBg,
                          border: Border.all(width: 0.7, color: Colores.secundario),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Center(
                          child: Text("Cancelar", style: TextStyle(color: Colores.secundario)),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () => anadirPabellon(context),
                      child: Container(
                        height: 40,
                        width: 130,
                        decoration: BoxDecoration(
                          color: Colores.secundario,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Center(
                          child: Text("Añadir", style: TextStyle(color: Colores.textos)),
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildTextField({
    required TextEditingController controlador,
    required String label,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return SizedBox(
      height: 50,
      width: 280,
      child: TextField(
        controller: controlador,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(color: Colores.secundario, fontSize: 14),
          prefixIcon: Icon(icon, color: Colores.secundario, size: 20),
          fillColor: Colores.panelBg,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colores.secundario, width: 0.7),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colores.secundario, width: 1.2),
          ),
        ),
        style: TextStyle(color: Colores.textos),
      ),
    );
  }

  Widget _buildPabellonItem(dynamic pabellon) {
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
              child: Icon(Icons.apartment_outlined, color: Colores.secundario),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Pabellón ${pabellon.id}",
                style: TextStyle(color: Colores.textos, fontSize: 17),
              ),
              Text(
                "Gestionar pabellón",
                style: TextStyle(color: Colores.textos2, fontSize: 13),
              ),
            ],
          ),
          Spacer(),
          Icon(Icons.chevron_right, color: Colores.muted),
          const SizedBox(width: 15),
          InkWell(
            onTap: () {
              // Lógica para eliminar si fuera necesario
            },
            child: Icon(Icons.delete_outlined, color: Colores.rojo, size: 28),
          ),
          const SizedBox(width: 20),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 385, // Igualado al diseño de AdminLlaves
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
                    _mostrarDialogoAnadir(context);
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
                          "Añadir Pabellón",
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
          const SizedBox(height: 15),
          Container(
            height: 290, // Altura de la lista igual a AdminLlaves
            width: 360,
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: Colores.panelBg,
              border: Border.all(color: Colores.borde, width: 1),
            ),
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                for (int i = 0; i < widget.pabellones.length; i++)
                  _buildPabellonItem(widget.pabellones[i]),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
