import 'package:flutter/material.dart';
import 'package:evaluacion_practica/Paginas/PaginaJuego.dart';
import 'package:evaluacion_practica/Paginas/PaginaRecursos.dart';
import 'PaginaJuegoPro.dart';

class PaginaPrincipal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Kids Game'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PaginaJuego()),
                );
              },
              child: Text('Play'),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PaginaJuegoPro()),
                );
              },
              child: Text('Juego Pro'),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PaginaRecursos()),
                );
              },
              child: Text('Additional Resources'),
            ),
          ],
        ),
      ),
    );
  }
}