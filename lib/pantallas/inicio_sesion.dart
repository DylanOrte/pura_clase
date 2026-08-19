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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colores.fondo,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 50),
              const Text(
                "PuraClase",
                style: TextStyle(fontSize: 34, color: Colors.white, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Text(
                "Inicia sesión para continuar",
                style: TextStyle(fontSize: 18, color: Colores.textos),
              ),
              const SizedBox(height: 40),
              Container(
                width: 320,
                decoration: BoxDecoration(
                  color: Colores.primario,
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 35),
                child: Column(
                  children: [
                    Texto_Is(texto: "Correo electrónico:"),
                    EntradaDeTextoIs(
                      pista: "Ingrese su correo",
                      controlador: controladorCorreo,
                      contrasena: false,
                      caracteresMax: 50,
                    ),
                    const SizedBox(height: 15),
                    Texto_Is(texto: "Contraseña:"),
                    EntradaDeTextoIs(
                      pista: "Ingrese su contraseña",
                      controlador: controladorContrasena,
                      contrasena: true,
                      caracteresMax: 20,
                    ),
                    const SizedBox(height: 30),
                    BtnIniciarsesion(
                      controladorNombre: controladorNombre,
                      controladorCorreo: controladorCorreo,
                      controladorContrasena: controladorContrasena,
                      controladorConfirmarContrasena: controladorConfirmarContrasena,
                    ),
                    const SizedBox(height: 25),
                    const Divider(color: Colors.white10),
                    const SizedBox(height: 25),
                    const BtnCrearCuenta(),
                  ],
                ),
              ),
              const SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }
}
