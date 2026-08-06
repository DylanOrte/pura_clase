import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pura_clase/assets/colores.dart';
import 'package:pura_clase/pantallas/principal.dart';
import 'package:pura_clase/pantallas/perfil.dart';

class ControladorPantallas extends StatefulWidget {
  final String nombreProfesor;
  final String correoProfesor;
  const ControladorPantallas({
    super.key,
    required this.nombreProfesor,
    required this.correoProfesor,
  });

  @override
  State<ControladorPantallas> createState() => _ControladorPantallasState();
}

class _ControladorPantallasState extends State<ControladorPantallas> {
  int _indiceActual = 0;
  late final List<Widget> _pantallas;

  @override
  void initState() {
    super.initState();
    _pantallas = [
      Principal(),
      Perfil(nombreProfesor: widget.nombreProfesor, correoProfesor: widget.correoProfesor),
    ];
  }

  void _onTabTapped(int indice) {
    setState(() {
      _indiceActual = indice;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    extendBody: true,
    backgroundColor: Colors.transparent,
    body: IndexedStack(
      index: _indiceActual,
      children: _pantallas, 
    ),
    bottomNavigationBar: SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 60),
        child: Container(
            height: 78,
            decoration: BoxDecoration(
              color: Colores.panelBg,
              borderRadius: BorderRadius.circular(50),
              border: Border.all(color: Colores.borde, width: 1.5),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: BottomNavigationBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                type: BottomNavigationBarType.fixed,
                currentIndex: _indiceActual,
                onTap: _onTabTapped,
                selectedItemColor: Colores.secundario,
                unselectedItemColor: Colores.textos,
                selectedIconTheme: IconThemeData(size: 35),
                unselectedIconTheme: IconThemeData(size: 30),
                selectedFontSize: 14,
                unselectedFontSize: 12,
                selectedLabelStyle: const TextStyle(height: 1.0),
                unselectedLabelStyle: const TextStyle(height: 1.0),
                items: const [
                  BottomNavigationBarItem(icon: Icon(Icons.apartment), label: 'Aulas'),
                  BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: 'Perfil'),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}