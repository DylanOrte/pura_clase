import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pura_clase/componentes/toast.dart';
import 'package:pura_clase/pantallas/escane.dart';
import 'package:pura_clase/pantallas/principal.dart';

class Llave extends StatefulWidget {
  String? profesorNombre;
  int? ocupada;
  final String numLlave;

  Llave({
    super.key,
    required this.numLlave,
    this.profesorNombre,
    this.ocupada
  });
  
  @override
  State<Llave> createState() => _LlaveState();
}
class _LlaveState extends State<Llave> {

  static const Color colorFondo = Color(0xFF0A1626);
  static const Color teal = Color(0xFF14B8A6);
  static const Color tealOscuro = Color(0xFF0D9488);
  static const Color rojo = Color(0xFFEF4444);
  static const Color rojoOscuro = Color(0xFFB91C1C);
  static const Color muted = Color(0xFF8FA3B8);
  static const Color texto = Color(0xFFF1F5F9);

  Color get colorPrincipal => widget.ocupada == 1 ? rojo : teal;
  Color get colorSecundario => widget.ocupada == 1 ? rojoOscuro : tealOscuro;

  Future<void> _escanearParaTomarLlave() async {
    final nombre = await Navigator.push<String>(
      context,
      MaterialPageRoute(builder: (context) => EscanerQR(numeroLlave: widget.numLlave)),
    );

    if (nombre != null && nombre.isNotEmpty) {
      setState(() {
        widget.ocupada = 1;
        widget.profesorNombre = nombre;
      });
    }
  }

  void _entregarLlave() async {
    final Map<String, String> body = {
      "llave" : widget.numLlave,
      "estado" : "0",
      "profesor" : "",
    }; 
      final uri = Uri.parse("https://api-pura-clase.onrender.com/api/api.php");

      try {
        final response = await http.put(uri, body: jsonEncode(body));
        if (response.statusCode == 200) {
          Toast.show(context, response.body);
        } else {
          Toast.show(context, "Error: ${response.body}");
        } 
      }catch (error) {
        Toast.show(context, "Error en catch: $error");
    }
  }

  
  @override
  Widget build(BuildContext context) {
    if (widget.profesorNombre == null) {
    widget.profesorNombre = "";
    } 
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: colorPrincipal.withOpacity(0.25)),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [colorPrincipal.withOpacity(0.08), colorFondo.withOpacity(0.4)],
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [colorPrincipal, colorSecundario],
              ),
            ),
            child: const Icon(Icons.vpn_key_outlined, color: Colors.white, size: 28),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Llave ${widget.numLlave}',
                    style: const TextStyle(color: texto, fontSize: 19, fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                if (widget.ocupada == 1) ...[
                  const Text('Ocupada por', style: TextStyle(color: muted, fontSize: 12)),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: rojo.withOpacity(0.25),
                        ),
                        child: const Icon(Icons.person, size: 16, color: rojo),
                      ),
                      const SizedBox(width: 8),
                      Flexible(
                        child: Text(widget.profesorNombre!,
                            style: const TextStyle(color: texto, fontSize: 14, fontWeight: FontWeight.w600),
                            overflow: TextOverflow.ellipsis),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                ],
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: colorPrincipal.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 7,
                        height: 7,
                        decoration: BoxDecoration(color: colorPrincipal, shape: BoxShape.circle),
                      ),
                      const SizedBox(width: 6),
                      Text(widget.ocupada == 1 ? 'Ocupada' : 'Disponible',
                          style: TextStyle(color: colorPrincipal, fontSize: 10, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          widget.ocupada == 1
              ? OutlinedButton.icon(
            onPressed: _entregarLlave,
            style: OutlinedButton.styleFrom(
              foregroundColor: rojo,
              side: const BorderSide(color: rojo, width: 1.5),
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            icon: const Icon(Icons.assignment_return_outlined, size: 18),
            label: const Text('Entregar llave', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
          )
              : ElevatedButton.icon(
            onPressed: _escanearParaTomarLlave,
            style: ElevatedButton.styleFrom(
              backgroundColor: teal,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            icon: const Icon(Icons.qr_code_scanner, size: 18),
            label: const Text('Tomar llave', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
          ),
        ],
      ),
    );
  }
}

