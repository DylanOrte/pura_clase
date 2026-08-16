import 'package:flutter/material.dart';
import 'package:pura_clase/pantallas/escane.dart';

class Llave extends StatefulWidget {
  final String numLlave;
  final String profesorNombre;
  final String ocupada;

  const Llave({
    super.key,
    required this.numLlave,
    required this.profesorNombre,
    required this.ocupada,
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

  Future<void> _escanearParaTomarLlave() async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EscanerQR(numeroLlave: widget.numLlave),
      ),
    );
  }

  void _entregarLlave() {
    // Aquí puedes implementar la lógica para entregar la llave si es necesario
  }

  @override
  Widget build(BuildContext context) {
    final estaOcupada = widget.ocupada == "1";
    final colorPrincipal = estaOcupada ? rojo : teal;
    final colorSecundario = estaOcupada ? rojoOscuro : tealOscuro;

    return Container(
      padding: const EdgeInsets.all(12),
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
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [colorPrincipal, colorSecundario],
              ),
            ),
            child: const Icon(Icons.vpn_key_outlined, color: Colors.white, size: 22),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Llave ${widget.numLlave}',
                  style: const TextStyle(color: texto, fontSize: 16, fontWeight: FontWeight.bold),
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                if (estaOcupada) ...[
                  Flexible(
                    child: Text(
                      widget.profesorNombre,
                      style: const TextStyle(color: muted, fontSize: 12),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(height: 4),
                ],
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: colorPrincipal.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 6,
                        height: 6,
                        decoration: BoxDecoration(color: colorPrincipal, shape: BoxShape.circle),
                      ),
                      const SizedBox(width: 5),
                      Text(
                        estaOcupada ? 'Ocupada' : 'Disponible',
                        style: TextStyle(color: colorPrincipal, fontSize: 10, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          estaOcupada
              ? OutlinedButton(
                  onPressed: _entregarLlave,
                  style: OutlinedButton.styleFrom(
                    foregroundColor: rojo,
                    side: const BorderSide(color: rojo, width: 1),
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.assignment_return_outlined, size: 16),
                      SizedBox(width: 4),
                      Text('Entregar', style: TextStyle(fontSize: 12)),
                    ],
                  ),
                )
              : ElevatedButton(
                  onPressed: _escanearParaTomarLlave,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: teal,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    elevation: 0,
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.qr_code_scanner, size: 16),
                      SizedBox(width: 4),
                      Text('Tomar', style: TextStyle(fontSize: 12)),
                    ],
                  ),
                ),
        ],
      ),
    );
  }
}
