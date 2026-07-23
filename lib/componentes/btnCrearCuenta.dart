import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pura_clase/componentes/toast.dart';
import 'package:pura_clase/diseños/colores.dart';

class BtnCrearCuenta extends StatefulWidget {
  final TextEditingController controladorNombre;
  final TextEditingController controladorCorreo;
  final TextEditingController controladorContrasena;
  final TextEditingController controladorConfirmarContrasena;

  const BtnCrearCuenta({
    super.key,
    required this.controladorNombre,
    required this.controladorCorreo,
    required this.controladorContrasena,
    required this.controladorConfirmarContrasena,
  });

  @override
  State<BtnCrearCuenta> createState() => _BtnCrearCuentaState();
}

class _BtnCrearCuentaState extends State<BtnCrearCuenta> {
  bool botonPrecionado = false;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colores.secundario,
        foregroundColor: Colors.white,
      ),
      onPressed: () {
        if (botonPrecionado == false) {
          funcionBoton();
          botonPrecionado = true;
        }
      },
      child: Text("Crear cuenta"),
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
                    ? crearUsuarioAPI()
                    : Toast.show(
                        context,
                        "Contraseñas diferentes, asegurese de escribirlas correctamente",
                      )
              : Toast.show(context, "Correo inválido")
        : Toast.show(context, "Debes completar todos los campos");
  }

  void crearUsuarioAPI() async {
    String url = "http://www.pura-clase-api.infinityfree.me/htdocs/";

    final Map<String, String> body = {
      "nombre": widget.controladorNombre.text,
      "correo": widget.controladorCorreo.text,
      "contrasena": widget.controladorContrasena.text,
    };
    try {
      http.Response respuesta = await http.post(
        Uri.parse(url),
        body: jsonEncode(body),
      );
      print(respuesta.statusCode);
      if (respuesta.statusCode == 200) {
        setState(() {
          Toast.show(context, respuesta.body);
        });
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
