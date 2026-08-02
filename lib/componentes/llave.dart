import 'package:flutter/material.dart';
import 'package:pura_clase/assets/colores.dart';
class Llave extends StatefulWidget {
  final String numLlave;
  final int? capacidad;

  const Llave({
    super.key,
    required this.numLlave,
    this.capacidad,
  });

  @override
  State<Llave> createState() => _LlaveState();
}

class _LlaveState extends State<Llave> {
  bool ocupada = false;
  String profesorNombre = '';

  Color get colorPrincipal => ocupada ? Colores.rojo : Colores.secundario;
  Color get colorSecundario => ocupada ? Colores.rojoOscuro : Colores.tercero;

  Future<void> _abrirDialogoTomarLlave() async {
    final controller = TextEditingController();
    String? error;

    final nombre = await showDialog<String>(
      context: context,
      barrierColor: Colors.black.withOpacity(0.6),
      builder: (ctx) {
        return StatefulBuilder(
          builder: (ctx, setDialogState) {
            return Dialog(
              backgroundColor: const Color(0xFF0F1F33),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Tomar llave',
                        style: TextStyle(color: Colores.textos, fontSize: 17, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 4),
                    const Text('Escribe el nombre del profesor que se lleva la llave.',
                        style: TextStyle(color: Colores.muted, fontSize: 13)),
                    const SizedBox(height: 14),
                    TextField(
                      controller: controller,
                      autofocus: true,
                      style: const TextStyle(color: Colores.textos),
                      decoration: InputDecoration(
                        hintText: 'Ej: Josgart Torres',
                        hintStyle: const TextStyle(color: Colores.muted),
                        errorText: error,
                        filled: true,
                        fillColor: Colores.fondo,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(color: Colors.white24),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(color: Colores.secundario),
                        ),
                      ),
                      onSubmitted: (_) {
                        if (controller.text.trim().isEmpty) {
                          setDialogState(() => error = 'Escribe un nombre');
                        } else {
                          Navigator.pop(ctx, controller.text.trim());
                        }
                      },
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              foregroundColor: Colores.muted,
                              side: const BorderSide(color: Colors.white24),
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                            ),
                            onPressed: () => Navigator.pop(ctx),
                            child: const Text('Cancelar'),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colores.secundario,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                            ),
                            onPressed: () {
                              if (controller.text.trim().isEmpty) {
                                setDialogState(() => error = 'Escribe un nombre');
                              } else {
                                Navigator.pop(ctx, controller.text.trim());
                              }
                            },
                            child: const Text('Confirmar', style: TextStyle(fontWeight: FontWeight.bold)),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
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
          colors: [colorPrincipal.withOpacity(0.08), Colores.fondo.withOpacity(0.4)],
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
                    style: const TextStyle(color: Colores.textos, fontSize: 19, fontWeight: FontWeight.bold)),
                // Probablemente borrable
                if (widget.capacidad != null) ...[
                  const SizedBox(height: 2),
                  Row(
                    children: [
                      const Icon(Icons.groups_outlined, size: 15, color: Colores.muted),
                      const SizedBox(width: 6),
                      Text('Capacidad: ${widget.capacidad}', style: const TextStyle(color: Colores.muted, fontSize: 13)),
                    ],
                  ),
                ],
                const SizedBox(height: 8),
                if (ocupada) ...[
                  const Text('Ocupada por', style: TextStyle(color: Colores.muted, fontSize: 12)),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colores.rojo.withOpacity(0.25),
                        ),
                        child: const Icon(Icons.person, size: 16, color: Colores.rojo),
                      ),
                      const SizedBox(width: 8),
                      Flexible(
                        child: Text(profesorNombre,
                            style: const TextStyle(color: Colores.textos, fontSize: 14, fontWeight: FontWeight.w600),
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
              foregroundColor: Colores.rojo,
              side: const BorderSide(color: Colores.rojo, width: 1.5),
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            icon: const Icon(Icons.assignment_return_outlined, size: 18),
            label: const Text('Entregar llave', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
          )
              : ElevatedButton.icon(
            onPressed: _abrirDialogoTomarLlave,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colores.secundario,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            icon: const Icon(Icons.vpn_key_outlined, size: 18),
            label: const Text('Tomar llave', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
          ),
        ],
      ),
    );
  }
}

