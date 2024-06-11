import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:evaluacion_practica/Paginas/PaginaJuego.dart';
import 'package:evaluacion_practica/Paginas/PaginaRecursos.dart';
import 'PaginaJuegoPro.dart';

class PaginaPrincipal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        title: Center(
          child: AnimatedTextKit(
            animatedTexts: [
              WavyAnimatedText(
                'Identificar Decenas',
                textStyle: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ],
            isRepeatingAnimation: true,
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.lightBlue[50] ?? Colors.lightBlueAccent,
              Colors.cyan[100] ?? Colors.cyanAccent
            ],
          ),
        ),
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.all(20.0),
                  padding: EdgeInsets.all(20.0),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.8),
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 10.0,
                      ),
                    ],
                  ),
                  child: Text(
                    '¡Bienvenidos al Juego para Niños! Disfruta de diferentes niveles de juegos y aprende mientras juegas. ¡Diviértete!',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                _buildGameCard(
                  context,
                  'assets/images/play.png',
                  'Jugar',
                  Colors.orange,
                  PaginaJuego(),
                  'Inicia el juego y comienza a aprender a identificar decenas.',
                ),
                _buildGameCard(
                  context,
                  'assets/images/pro.png',
                  'Juego Pro',
                  Colors.green,
                  PaginaJuegoPro(),
                  'Desafía tus habilidades con el modo profesional.',
                ),
                _buildGameCard(
                  context,
                  'assets/images/resources.png',
                  'Videos',
                  Colors.blue,
                  PaginaRecursos(),
                  'Accede a recursos adicionales y videos educativos.',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildGameCard(BuildContext context, String imagePath, String title, Color color, Widget nextPage, String description) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => nextPage),
        );
      },
      child: Container(
        width: MediaQuery.of(context).size.width * 0.8,
        margin: EdgeInsets.symmetric(vertical: 10.0),
        padding: EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              imagePath,
              height: 100,
            ),
            SizedBox(height: 10),
            Text(
              title,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 10),
            AnimatedTextKit(
              animatedTexts: [
                TypewriterAnimatedText(
                  description,
                  textStyle: TextStyle(
                    fontSize: 16.0,
                    color: Colors.white,
                  ),
                  speed: const Duration(milliseconds: 100),
                ),
              ],
              totalRepeatCount: 1,
            ),
          ],
        ),
      ),
    );
  }
}
