import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'PantallaCifras.dart';
import 'PantallasDr.dart';

class PantallaPrincipal extends StatefulWidget {
  @override
  State<PantallaPrincipal> createState() => _PantallaPrincipalState();
}

class _PantallaPrincipalState extends State<PantallaPrincipal> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      //AGREGAR APPBAR
      appBar: AppBar(
        title: Text("Menú Principal"),
        backgroundColor: Colors.pinkAccent,
        titleTextStyle: TextStyle(fontFamily: 'CustomFont', fontSize: 20, fontWeight: FontWeight.bold),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(onPressed: (){
              //CONEXION ENTRE PANTALLAS
              Navigator.push(context, MaterialPageRoute(builder:
                  (context)=>PantallasCifras(),),);

            }, child: const Text("EJERCICIO 1 - CIFRAS"),
            ),
            //SEPARACION ENTRE BOTONES
            SizedBox(height: 20,),
            ElevatedButton(onPressed: (){
              //CONEXION ENTRE PANTALLAS
              Navigator.push(context, MaterialPageRoute(builder:
                  (context)=>PantallasDoctor(),),);

            }, child: const Text("EJERCICIO 2 - DR. CONSULTA"),
            ),
          ],
        ),

      ),

    );

  }

}