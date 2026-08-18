import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pura_clase/componentes/toast.dart';
import 'package:pura_clase/assets/colores.dart';

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
        fixedSize: Size(250, 50),
        shape: RoundedRectangleBorder(borderRadius: BorderRadiusGeometry.circular(16)),
        textStyle: TextStyle(fontSize: 23, fontWeight: FontWeight(700)),
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
    String url = "https://api-pura-clase.onrender.com/api/api.php";

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
        _mostrarDialogoSolicitud();
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

  void _mostrarDialogoSolicitud() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 10),
              const Icon(Icons.check_circle_outline, color: Colors.green, size: 60),
              const SizedBox(height: 20),
              const Text(
                "Solicitud enviada",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  minimumSize: const Size(120, 45),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text("OK", style: TextStyle(fontSize: 18)),
              ),
            ],
          ),
        );
      },
    );
  }
}
