import 'package:pura_clase/componentes/btnCrearCuenta.dart';
import 'package:pura_clase/componentes/entradaDeTexto_IS.dart';
import 'package:pura_clase/componentes/texto_IS.dart';
import 'package:pura_clase/diseños/colores.dart';
import 'package:flutter/material.dart';
import 'package:pura_clase/pantallas/principal.dart';

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
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Spacer(),
          Text(
            "PuraClase",
            style: TextStyle(
              fontSize: 30,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            "Crea tu cuenta para comenzar",
            style: TextStyle(fontSize: 20, color: Colores.textos),
          ),
          Spacer(),
          Container(
            height: 600,
            width: 300,
            color: Colores.primario,
            child: Padding(
              padding: const EdgeInsets.only(top: 25, left: 25),
              child: Column(
                children: [
                  TextoIs(texto: "Nombre:"),
                  EntradaDeTextoIs(pista: "Ingrese su nombre", controlador: controladorNombre, contrasena: false),
                  TextoIs(texto: "Correo:"),
                  EntradaDeTextoIs(pista: "Ingrese su correo electronico", controlador: controladorCorreo, contrasena: false),
                  TextoIs(texto: "Contraseña:"),
                  EntradaDeTextoIs(pista: "Ingrese su contraseña", controlador: controladorContrasena, contrasena: true),
                  TextoIs(texto: "Confirmar contraseña:"),
                  EntradaDeTextoIs(pista: "Ingrese su contraseña", controlador: controladorConfirmarContrasena, contrasena: true),
                  BtnCrearCuenta(controladorNombre: controladorNombre, controladorCorreo: controladorCorreo,)
                ],
              ),
            ),
          ),
          Spacer(),
        ],
      ),
    );
  }
  
}
