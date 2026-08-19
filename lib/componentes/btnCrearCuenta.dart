import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pura_clase/componentes/toast.dart';
import 'package:pura_clase/assets/colores.dart';

class BtnCrearCuenta extends StatefulWidget {
  const BtnCrearCuenta({super.key});

  @override
  State<BtnCrearCuenta> createState() => _BtnCrearCuentaState();
}

class _BtnCrearCuentaState extends State<BtnCrearCuenta> {
  final controladorNombre = TextEditingController();
  final controladorCorreo = TextEditingController();
  final controladorContrasena = TextEditingController();
  final controladorConfirmarContrasena = TextEditingController();
  bool cargando = false;

  void crearUsuarioAPI(BuildContext context, StateSetter setDialogState) async {
    final nombre = controladorNombre.text.trim();
    final correo = controladorCorreo.text.trim();
    final pass = controladorContrasena.text.trim();
    final confirmPass = controladorConfirmarContrasena.text.trim();

    if (nombre.isEmpty || correo.isEmpty || pass.isEmpty || confirmPass.isEmpty) {
      Toast.show(context, "Debes completar todos los campos");
      return;
    }

    if (pass != confirmPass) {
      Toast.show(context, "Las contraseñas no coinciden");
      return;
    }

    setDialogState(() => cargando = true);
    const String url = "https://api-pura-clase.onrender.com/api/api.php";

    try {
      final respuesta = await http.post(
        Uri.parse(url),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "accion": "crear",
          "nombre": nombre,
          "correo": correo,
          "contrasena": pass,
        }),
      ).timeout(const Duration(seconds: 45));

      if (respuesta.statusCode == 200) {
        if (context.mounted) {
          Navigator.pop(context); // Cierra el diálogo de registro
          Toast.show(context, "Solicitud enviada");
          controladorNombre.clear();
          controladorCorreo.clear();
          controladorContrasena.clear();
          controladorConfirmarContrasena.clear();
        }
      } else {
        if (context.mounted) Toast.show(context, "Error: ${respuesta.body}");
      }
    } catch (error) {
      if (context.mounted) Toast.show(context, "Error de conexión");
    } finally {
      setDialogState(() => cargando = false);
    }
  }

  void _mostrarDialogoRegistro() {
    showDialog(
      context: context,
      barrierDismissible: !cargando,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              title: const Text(
                "Crear Cuenta",
                style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _buildTextField(controladorNombre, "Nombre completo", Icons.person, false),
                    const SizedBox(height: 10),
                    _buildTextField(controladorCorreo, "Correo electrónico", Icons.email, false),
                    const SizedBox(height: 10),
                    _buildTextField(controladorContrasena, "Contraseña", Icons.lock, true),
                    const SizedBox(height: 10),
                    _buildTextField(controladorConfirmarContrasena, "Confirmar contraseña", Icons.lock_outline, true),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: cargando ? null : () => Navigator.pop(context),
                  child: const Text("Cancelar", style: TextStyle(color: Colors.red)),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  onPressed: cargando ? null : () => crearUsuarioAPI(context, setDialogState),
                  child: cargando
                      ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                      : const Text("Registrar"),
                ),
              ],
            );
          },
        );
      },
    );
  }

  Widget _buildTextField(TextEditingController controller, String hint, IconData icon, bool isPass) {
    return TextField(
      controller: controller,
      obscureText: isPass,
      style: const TextStyle(color: Colors.black),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.grey),
        prefixIcon: Icon(icon, color: Colors.black54),
        filled: true,
        fillColor: Colors.grey[100],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colores.secundario,
        foregroundColor: Colors.white,
        fixedSize: const Size(250, 45),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      onPressed: _mostrarDialogoRegistro,
      child: const Text("Crear cuenta", style: TextStyle(fontWeight: FontWeight.bold)),
    );
  }
}
