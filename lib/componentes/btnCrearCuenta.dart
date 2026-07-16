import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pura_clase/componentes/toast.dart';
import 'package:pura_clase/diseños/colores.dart';
class BtnCrearCuenta extends StatefulWidget {
  final TextEditingController controladorNombre;
  final TextEditingController controladorCorreo;

  const BtnCrearCuenta({super.key, required this.controladorNombre, required this.controladorCorreo});

  @override
  State<BtnCrearCuenta> createState() => _BtnCrearCuentaState();
}

class _BtnCrearCuentaState extends State<BtnCrearCuenta> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(backgroundColor: Colores.secundario, foregroundColor: Colors.white),
      onPressed: () {
        setState(() {
          Toast.show(context, " ${widget.controladorNombre.text}, ${widget.controladorCorreo.text}");
        });
        
      },
      child: Text("Crear cuenta"),
    );
  }

  void recibirMensajeAPI() async {
    String url = "http://10.0.2.2/api/api.php";

    final Map<String, dynamic> queryParams = {
      "name" : "Donald Duck",
      "address" : "Disney Land",
    };

    try{
    http.Response respuesta = await http.get(Uri.parse(url).replace(queryParameters: queryParams));

    if (respuesta.statusCode == 200){
      setState(() {
        SnackBar(
          content: Text(respuesta.body),
          duration: Duration(seconds: 2),
        );
      });
    } else {
      setState(() {
        SnackBar(
          content: Text("${respuesta.statusCode} - ${respuesta.reasonPhrase}"),
          duration: Duration(seconds: 2),
        ); 
      });
    }
    }catch (error) {
      setState(() {
        SnackBar(
          content: Text("error"),
          duration: Duration(seconds: 2),
        );
      });
    }  
  }
}
