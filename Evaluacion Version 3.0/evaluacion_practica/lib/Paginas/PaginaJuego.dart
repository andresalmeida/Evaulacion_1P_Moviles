import 'dart:math';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class PaginaJuego extends StatefulWidget {
  @override
  _PaginaJuegoState createState() => _PaginaJuegoState();
}

class _PaginaJuegoState extends State<PaginaJuego> {
  int correctAnswers = 0;
  int incorrectAnswers = 0;
  int currentQuestion = 0;
  List<Map<String, dynamic>> questions = [];
  int? userAnswer;
  bool _isAnimationComplete = false;

  @override
  void initState() {
    super.initState();
    generateQuestions();
  }

  void generateQuestions() {
    questions = List.generate(20, (index) {
      int number = Random().nextInt(1000);
      int hundreds = number ~/ 100;
      int tens = (number ~/ 10) % 10;
      int ones = number % 10;
      int questionType = Random().nextInt(3); // 0 for hundreds, 1 for tens, 2 for ones
      String questionText;

      switch (questionType) {
        case 0:
          questionText = '¿Cuántos cientos hay en $number?';
          return {
            'type': 'specific_number',
            'number': number,
            'hundreds': hundreds,
            'tens': tens,
            'ones': ones,
            'correctAnswer': hundreds,
            'questionText': questionText,
          };
        case 1:
          questionText = '¿Cuántas decenas hay en $number?';
          return {
            'type': 'specific_number',
            'number': number,
            'hundreds': hundreds,
            'tens': tens,
            'ones': ones,
            'correctAnswer': tens,
            'questionText': questionText,
          };
        case 2:
          questionText = '¿Cuántas unidades hay en $number?';
          return {
            'type': 'specific_number',
            'number': number,
            'hundreds': hundreds,
            'tens': tens,
            'ones': ones,
            'correctAnswer': ones,
            'questionText': questionText,
          };
        default:
          return {};
      }
    });
  }

  void checkAnswer(int answer) {
    Map<String, dynamic> currentQuestionData = questions[currentQuestion];
    int correctAnswer = currentQuestionData['correctAnswer'];

    setState(() {
      userAnswer = answer;
      if (answer == correctAnswer) {
        correctAnswers++;
      } else {
        incorrectAnswers++;
      }
    });
  }

  void nextQuestion() {
    setState(() {
      userAnswer = null;
      if (currentQuestion < questions.length - 1) {
        currentQuestion++;
      } else {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Juego Terminado'),
              content: Text(
                'Respuestas Correctas: $correctAnswers\nRespuestas Incorrectas: $incorrectAnswers',
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
                  child: Text('Regresar'),
                ),
              ],
            );
          },
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> currentQuestionData = questions[currentQuestion];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Center(
          child: AnimatedSwitcher(
            duration: Duration(seconds: 2),
            child: _isAnimationComplete
                ? Text(
              'Juego nivel 1',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              key: ValueKey('Title'),
            )
                : AnimatedTextKit(
              animatedTexts: [
                FadeAnimatedText(
                  'Juego nivel 1',
                  textStyle: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
              totalRepeatCount: 1,
              onFinished: () {
                setState(() {
                  _isAnimationComplete = true;
                });
              },
              key: ValueKey('AnimatedTitle'),
            ),
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.orange[100]!, Colors.orange[300]!],
          ),
        ),
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Correctas: $correctAnswers',
                  style: TextStyle(fontSize: 18.0, color: Colors.black87),
                ),
                Text(
                  'Incorrectas: $incorrectAnswers',
                  style: TextStyle(fontSize: 18.0, color: Colors.black87),
                ),
              ],
            ),
            SizedBox(height: 16.0),
            Text(
              'Pregunta ${currentQuestion + 1}:',
              style: TextStyle(fontSize: 24.0, color: Colors.black87),
            ),
            SizedBox(height: 16.0),
            Text(
              currentQuestionData['questionText'],
              style: TextStyle(fontSize: 24.0, color: Colors.black87),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 32.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildNumberBox('${currentQuestionData['hundreds']}'),
                SizedBox(width: 8.0),
                _buildNumberBox('${currentQuestionData['tens']}'),
                SizedBox(width: 8.0),
                _buildNumberBox('${currentQuestionData['ones']}'),
              ],
            ),
            SizedBox(height: 32.0),
            if (userAnswer != null)
              Text(
                'Tu respuesta: $userAnswer\nRespuesta correcta: ${currentQuestionData['correctAnswer']}',
                style: TextStyle(fontSize: 18.0, color: Colors.black87),
                textAlign: TextAlign.center,
              ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                if (userAnswer == null) {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Enviar Respuesta'),
                        content: TextField(
                          keyboardType: TextInputType.number,
                          onSubmitted: (value) {
                            checkAnswer(int.parse(value));
                            Navigator.pop(context);
                          },
                          decoration: InputDecoration(
                            hintText: 'Ingresa tu respuesta',
                          ),
                        ),
                      );
                    },
                  );
                } else {
                  nextQuestion();
                }
              },
              child: Text(userAnswer == null ? 'Enviar Respuesta' : 'Siguiente'),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white, backgroundColor: Colors.orange[800],
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Regresar'),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white, backgroundColor: Colors.grey,
              ),
            ),
            SizedBox(height: 16.0),
            Expanded(
              child: Center(
                child: Image.asset(
                  'assets/images/animation.gif',
                  height: 200,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNumberBox(String number) {
    return Container(
      width: 50.0,
      height: 50.0,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black87),
        color: Colors.white.withOpacity(0.8),
      ),
      child: Center(
        child: Text(
          number,
          style: TextStyle(fontSize: 24.0, color: Colors.black87),
        ),
      ),
    );
  }
}
