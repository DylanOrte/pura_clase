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

  void iniciarSesion() async {
    final correo = widget.controladorCorreo.text.trim();
    final pass = widget.controladorContrasena.text.trim();


    if (correo.isEmpty || pass.isEmpty) {
      Toast.show(context, "Por favor complete todos los campos");
      return;
    }

    setState(() => cargando = true);
    const String url = "https://api-pura-clase.onrender.com/api/api.php";

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "accion": "login",
          "nombre": widget.controladorNombre.text.trim(),
          "correo": correo,
          "contrasena": pass,
          "proceder": "no",
        }),
      ).timeout(const Duration(seconds: 45));

      if (response.statusCode == 200) {
        if (mounted) {
          Toast.show(context, "Inicio de sesión exitoso");

          String nombreAMostrar = "Profesor";
          try {
            final data = jsonDecode(response.body);
            if (data['nombre'] != null) nombreAMostrar = data['nombre'];
          } catch (_) {

          }

          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => ControladorPantallas(
                nombreProfesor: nombreAMostrar,
                correoProfesor: correo,
              ),
            ),
          );
        }
      } else {
        if (mounted) Toast.show(context, "Error: ${response.body}");
      }
    } catch (e) {
      if (mounted) Toast.show(context, "Error de conexión: Intente de nuevo");
    } finally {
      if (mounted) setState(() => cargando = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: cargando ? null : iniciarSesion,
      child: Container(
        alignment: Alignment.center,
        height: 45,
        width: 250,
        decoration: BoxDecoration(
          color: Colors.white10,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.white24)
        ),
        child: cargando 
          ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
          : const Text("Iniciar Sesión", style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );
  }
}
