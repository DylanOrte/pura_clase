import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:pura_clase/assets/colores.dart';
import 'package:pura_clase/componentes/toast.dart';

class EscanerQR extends StatefulWidget {
  final String numeroLlave;
  const EscanerQR({super.key, required this.numeroLlave});

  @override
  State<EscanerQR> createState() => _EscanerQRState();
}
class _EscanerQRState extends State<EscanerQR> {
  String? code;
  bool accionado = false;
  void ocuparLlave() async {
    final Map<String, String> body = {
      "llave" : widget.numeroLlave,
      "estado" : "1",
      "profesor" : code!,
    }; 
      final uri = Uri.parse("https://api-pura-clase.onrender.com/api/api.php");

      try {
        final response = await http.put(uri, body: jsonEncode(body));
        if (response.statusCode == 200) {
          Toast.show(context, response.body);
          await Future.delayed(Duration(milliseconds: 1000));
          Navigator.pop(context);
        } else {
          Toast.show(context, "Error: ${response.body}");
        } 
      }catch (error) {
        Toast.show(context, "Error en catch: $error");
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Escanear Código QR', style: TextStyle(color: Colors.white)),
        backgroundColor: Colores.fondo,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Stack(
        children: [
          MobileScanner(
            onDetect: (capture) {
              final List<Barcode> barcodes = capture.barcodes;
              for (final barcode in barcodes) {
                if (barcode.rawValue != null && accionado == false) {
                  accionado = true;
                  code = barcode.rawValue!;
                  ocuparLlave();
                }
              }
            },
          ),
          Center(
            child: Container(
              width: 250,
              height: 250,
              decoration: BoxDecoration(
                border: Border.all(color: Colores.secundario, width: 4),
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
          Positioned(
            bottom: 150,
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.black54,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'Apunta al código QR del perfil',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
