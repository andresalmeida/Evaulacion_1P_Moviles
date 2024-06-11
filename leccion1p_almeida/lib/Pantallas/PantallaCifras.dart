// CREACION DE PRIMERA PANTALLA

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PantallasCifras extends StatefulWidget {
  @override
  State<PantallasCifras > createState() => _PantallaCifrasState();
}

class _PantallaCifrasState extends State<PantallasCifras> {
  //Controlador para el campo de texto del número
  final _numeroController = TextEditingController();

  //Variable para almacenar el número ingresado
  String _numero = '';

  //Variable para almacenar la cantidad de dígitos
  int _cantidadDigitos = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Contar Dígitos"),
        backgroundColor: Colors.lightGreen,
        titleTextStyle: TextStyle(fontFamily: 'CustomFont', fontSize: 20, fontWeight: FontWeight.bold),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TextField(
            controller: _numeroController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: 'Ingrese un número',
              border: OutlineInputBorder(),
            ),
            onChanged: (valor) {
              //Validar que solo se ingresen números
              if (valor.isNotEmpty && num.tryParse(valor) != null) {
                setState(() {
                  _numero = valor;
                });
              }
            },
          ),
          SizedBox(height: 32),
          ElevatedButton(
            onPressed: () {
              //Contar dígitos del número
              if (_numero.isNotEmpty) {
                setState(() {
                  _cantidadDigitos = contarDigitos(_numero);
                });
              }
            },
            child: Text('Contar Dígitos'),
          ),
          SizedBox(height: 32),
          Text('Cantidad de dígitos: $_cantidadDigitos'),
        ],
      ),
    );
  }

  //Función para contar dígitos de un número
  int contarDigitos(String numero) {
    int cantidadDigitos = 0;
    for (int i = 0; i < numero.length; i++) {
      if (numero[i] != ' ') {
        cantidadDigitos++;
      }
    }
    return cantidadDigitos;
  }
}