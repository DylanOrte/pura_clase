import 'package:flutter/material.dart';
import 'package:pura_clase/pantallas/escane.dart';

class Llave extends StatefulWidget {
  final String numLlave;

  const Llave({
    super.key,
    required this.numLlave,
  });

  @override
  State<Llave> createState() => _LlaveState();
}

class _LlaveState extends State<Llave> {
  bool ocupada = false;
  String profesorNombre = '';

  static const Color colorFondo = Color(0xFF0A1626);
  static const Color teal = Color(0xFF14B8A6);
  static const Color tealOscuro = Color(0xFF0D9488);
  static const Color rojo = Color(0xFFEF4444);
  static const Color rojoOscuro = Color(0xFFB91C1C);
  static const Color muted = Color(0xFF8FA3B8);
  static const Color texto = Color(0xFFF1F5F9);

  Color get colorPrincipal => ocupada ? rojo : teal;
  Color get colorSecundario => ocupada ? rojoOscuro : tealOscuro;

  /*Notas para el socio Dylan para que vea lo que hice: aqui se cambio el boton de tomar llave ahora apenas se
  presiona se habre el escaner y ya no se introduce manual la informacion del profesor.
   */
  Future<void> _escanearParaTomarLlave() async {
    final nombre = await Navigator.push<String>(
      context,
      MaterialPageRoute(builder: (context) => const EscanerQR()),
    );

    if (nombre != null && nombre.isNotEmpty) {
      setState(() {
        ocupada = true;
        profesorNombre = nombre;
      });
    }
  }

  void _entregarLlave() {
    setState(() {
      ocupada = false;
      profesorNombre = '';
    });
  }

  @override
  Widget build(BuildContext context) {
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
                if (ocupada) ...[
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
                        child: Text(profesorNombre,
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
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 7,
                        height: 7,
                        decoration: BoxDecoration(color: colorPrincipal, shape: BoxShape.circle),
                      ),
                      const SizedBox(width: 6),
                      Text(ocupada ? 'Ocupada' : 'Disponible',
                          style: TextStyle(color: colorPrincipal, fontSize: 12, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          ocupada
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

