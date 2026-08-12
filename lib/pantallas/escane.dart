import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:pura_clase/assets/colores.dart';

class EscanerQR extends StatefulWidget {
  const EscanerQR({super.key});

  @override
  State<EscanerQR> createState() => _EscanerQRState();
}
/*
La forma mas facil de hacer el escaner era descargando un paquete que se llama mobile_escaner y
luego ya nada mas hacer el widget y cambiar la funcion del boton para tomar la llave

 */
class _EscanerQRState extends State<EscanerQR> {
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
                if (barcode.rawValue != null) {
                  final String code = barcode.rawValue!;
                  debugPrint('QR Encontrado: $code');
                  Navigator.pop(context, code);
                  break;
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
            bottom: 50,
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
