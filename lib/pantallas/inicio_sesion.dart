import 'package:pura_clase/componentes/btnCrearCuenta.dart';
import 'package:pura_clase/componentes/entradaDeTexto_IS.dart';
import 'package:pura_clase/componentes/texto_IS.dart';
import 'package:pura_clase/assets/colores.dart';
import 'package:flutter/material.dart';
import 'package:pura_clase/componentes/btn_IniciarSesion.dart';

class InicioSesion extends StatefulWidget {
  const InicioSesion({super.key});

  @override
  State<InicioSesion> createState() => _InicioSesionState();
}

class _InicioSesionState extends State<InicioSesion> {
  final controladorNombre = TextEditingController();
  final controladorCorreo = TextEditingController();
  final controladorContrasena = TextEditingController();
  final controladorConfirmarContrasena = TextEditingController();
  String msg = "Mensaje";
  String nombreUsuario = "No asignado";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colores.fondo,
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Spacer(),
            Image.asset("lib/assets/imagenes/logoApp.png", height: 100),
            const SizedBox(height: 12),
            Text(
              "PuraClase",
              style: TextStyle(
                fontSize: 34,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "Crea tu cuenta para comenzar",
              style: TextStyle(fontSize: 20, color: Colores.textos),
            ),
            const SizedBox(height: 24),
            Container(
              height: 625,
              width: 325,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colores.primario,
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    Spacer(),
                    Texto_Is(texto: "Nombre:"),
                    EntradaDeTextoIs(
                      pista: "Ingrese su nombre",
                      controlador: controladorNombre,
                      contrasena: false,
                      caracteresMax: 20,
                    ),
                    Texto_Is(texto: "Correo electrónico:"),
                    EntradaDeTextoIs(
                      pista: "Ingrese su correo electronico",
                      controlador: controladorCorreo,
                      contrasena: false,
                      caracteresMax: 60,
                    ),
                    Texto_Is(texto: "Contraseña:"),
                    EntradaDeTextoIs(
                      pista: "Ingrese su contraseña",
                      controlador: controladorContrasena,
                      contrasena: true,
                      caracteresMax: 40,
                    ),
                    Texto_Is(texto: "Confirmar contraseña:"),
                    EntradaDeTextoIs(
                      pista: "Confirme su contraseña",
                      controlador: controladorConfirmarContrasena,
                      contrasena: true,
                      caracteresMax: 40,
                    ),
                    SizedBox(height: 5),
                    BtnCrearCuenta(
                      controladorNombre: controladorNombre,
                      controladorCorreo: controladorCorreo,
                      controladorContrasena: controladorContrasena,
                      controladorConfirmarContrasena:
                          controladorConfirmarContrasena,
                    ),
                    SizedBox(height: 10),
                    BtnIniciarsesion(
                      controladorNombre: controladorNombre,
                      controladorCorreo: controladorCorreo,
                      controladorContrasena: controladorContrasena,
                      controladorConfirmarContrasena:
                          controladorConfirmarContrasena,
                    ),
                    Spacer(),
                  ],
                ),
              ),
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
