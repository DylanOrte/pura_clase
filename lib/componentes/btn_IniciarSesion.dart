import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pura_clase/componentes/toast.dart';
import 'package:pura_clase/pantallas/controlador_pantallas.dart';
import 'package:pura_clase/pantallas/principal.dart';


class BtnIniciarsesion extends StatefulWidget {
  final TextEditingController controladorNombre;
  final TextEditingController controladorCorreo;
  final TextEditingController controladorContrasena;
  final TextEditingController controladorConfirmarContrasena;

  const BtnIniciarsesion({
    super.key,
    required this.controladorNombre,
    required this.controladorCorreo,
    required this.controladorContrasena,
    required this.controladorConfirmarContrasena,
  });

  @override
  State<BtnIniciarsesion> createState() => _BtnIniciarsesionState();
}

class _BtnIniciarsesionState extends State<BtnIniciarsesion> {
  bool botonPrecionado = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (botonPrecionado == false) {
          botonPrecionado = true;
          funcionBoton();
        }
      },
      child: Text(
        "Iniciar Sesión",
        style: TextStyle(fontSize: 20, color: Colors.white),
      ),
    );
  }

  void funcionBoton() {
    widget.controladorNombre.text != "" &&
            widget.controladorCorreo.text != "" &&
            widget.controladorContrasena.text != "" &&
            widget.controladorConfirmarContrasena.text != ""
        ? widget.controladorCorreo.text.contains("@")
              ? widget.controladorContrasena.text ==
                        widget.controladorConfirmarContrasena.text
                    ? iniciarSesion()
                    : Toast.show(
                        context,
                        "Contraseñas diferentes, asegurese de escribirlas correctamente",
                      )
              : Toast.show(context, "Correo inválido")
        : Toast.show(context, "Debes completar todos los campos");
  }

  void iniciarSesion() async {
    String url = "https://api-pura-clase.onrender.com/api/api.php";

    final Map<String, String> body = {
      "accion": "login",
      "nombre": widget.controladorNombre.text,
      "correo": widget.controladorCorreo.text,
      "contrasena": widget.controladorContrasena.text,
    };

    try {
      http.Response respuesta = await http.post(
        Uri.parse(url),
        body: jsonEncode(body),
      );
      if (respuesta.statusCode == 200) {
        setState(() {
          Toast.show(context, respuesta.body);
          print(respuesta.body.toString());
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ControladorPantallas(nombreProfesor: widget.controladorNombre.text, correoProfesor: widget.controladorCorreo.text),
            ),
          );
          }
        );
      } else {
        setState(() {
          Toast.show(context, respuesta.body);
        });
      }
    } catch (error) {
      setState(() {
        Toast.show(context, "Error");
      });
    } finally {
      botonPrecionado = false;
    }
  }
}
