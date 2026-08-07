import 'package:flutter/material.dart';
import 'package:pura_clase/assets/colores.dart';
import 'package:pura_clase/pantallas/inicio_sesion.dart';
import 'package:qr_flutter/qr_flutter.dart';

class Perfil extends StatefulWidget {
  final String nombreProfesor;
  final String correoProfesor;
  const Perfil({super.key, required this.nombreProfesor, required this.correoProfesor});

  @override
  State<Perfil> createState() => _PerfilState();
}

class _PerfilState extends State<Perfil> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colores.fondo,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 30, left: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Mi perfil",
                    style: TextStyle(
                      fontSize: 30,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "Tu información y código personal",
                    style: TextStyle(fontSize: 15, color: Colores.textos2),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 550,
                  width: 375,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: Colores.panelBg,
                    border: Border.all(color: Colores.borde, width: 1),
                  ),
                  child: Column(
                    children: [
                      SizedBox(height: 20),
                      Container(
                        height: 85,
                        width: 85,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colores.secundario.withAlpha(10),
                        ),
                        child: Icon(
                          Icons.person_outline,
                          color: Colores.secundario,
                          size: 70,
                        ),
                      ),
                      Text(
                        widget.nombreProfesor,
                        style: TextStyle(
                          fontSize: 25,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        widget.correoProfesor,
                        style: TextStyle(fontSize: 18, color: Colores.textos2),
                      ),
                      Padding(
                        padding: EdgeInsetsGeometry.all(18),
                        child: Container(
                          height: 250,
                          width: 250,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: QrImageView(
                              data: '${widget.nombreProfesor} ${widget.correoProfesor}',
                              version: QrVersions.auto,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        "Utiliza este código para tomar una llave",
                        style: TextStyle(fontSize: 15, color: Colores.textos2),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 75,
                  width: 375,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: Colores.panelBg,
                    border: Border.all(color: Colores.borde, width: 1),
                  ),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const InicioSesion(),
                        ),
                      );
                    },
                    child: Row(
                      children: [
                        SizedBox(width: 25),
                        Icon(Icons.exit_to_app, color: Colores.rojo, size: 28),
                        SizedBox(width: 10),
                        Text(
                          "Cerrar Sesión",
                          style: TextStyle(fontSize: 17, color: Colores.rojo),
                        ),
                        SizedBox(width: 160),
                        Icon(Icons.chevron_right, color: Colores.rojo, size: 30),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
