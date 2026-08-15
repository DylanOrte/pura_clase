import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pura_clase/assets/colores.dart';
import 'package:pura_clase/pantallas/administracion.dart';
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
/*
Posible solucion>=(preguntar a tu IA de confianza)
Para solucionar que el botton navigation bar se superponga encima de la screen una posible
solucion es crear dentro del Stack creado un positioned flotante y ahi mismo importar el widget de
bottom navigation bar, ademas crear un archivo dedicado al bottonnavigationBar exclusivamente para orden
que la estructura sea
Stack(
Child (pantallas)
Positioned(
bottomNavigationBar sin fondo, solamente el container)
)
* */

class _ControladorPantallasState extends State<ControladorPantallas> {
  int _indiceActual = 0;
  late final List<Widget> _pantallas;

  @override
  void initState() {
    super.initState();
    _pantallas = [
      Principal(),
      Perfil(nombreProfesor: widget.nombreProfesor, correoProfesor: widget.correoProfesor),
      Administracion()
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
                  BottomNavigationBarItem(icon: Icon(Icons.apartment), label: 'Llaves'),
                  BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: 'Perfil'),
                  BottomNavigationBarItem(icon: Icon(Icons.admin_panel_settings_outlined), label: 'Admin')
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}