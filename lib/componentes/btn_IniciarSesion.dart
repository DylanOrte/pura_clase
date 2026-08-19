import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pura_clase/componentes/toast.dart';
import 'package:pura_clase/pantallas/controlador_pantallas.dart';

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
  bool cargando = false;
  String? respuestaApi;
  void funcionBoton() {
    widget.controladorCorreo.text != "" &&
            widget.controladorContrasena.text != ""
        ? widget.controladorCorreo.text.contains("@")
              ? iniciarSesion()
              : Toast.show(context, "Correo inválido")
        : Toast.show(context, "Debes completar todos los campos");
  }

  void iniciarSesion() async {
    String url = "https://api-pura-clase.onrender.com/api/api.php";

    final Map<String, String> body = {
      "accion": "login",
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
          Toast.show(context, "Inicio de sesion exitoso");
          respuestaApi = jsonDecode(respuesta.body);
          print(respuestaApi);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ControladorPantallas(
                nombreProfesor: respuestaApi!,
                correoProfesor: widget.controladorCorreo.text,
              ),
            ),
          );
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
      cargando = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: cargando ? null : funcionBoton,
      child: Container(
        alignment: Alignment.center,
        height: 45,
        width: 250,
        decoration: BoxDecoration(
          color: Colors.white10,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.white24),
        ),
        child: cargando
            ? const SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 2,
                ),
              )
            : const Text(
                "Iniciar Sesión",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
      ),
    );
  }
}
