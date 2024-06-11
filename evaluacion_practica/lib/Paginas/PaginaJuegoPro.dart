import 'dart:math';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class PaginaJuegoPro extends StatefulWidget {
  @override
  _PaginaJuegoProState createState() => _PaginaJuegoProState();
}

class _PaginaJuegoProState extends State<PaginaJuegoPro> {
  int correctAnswers = 0;
  int incorrectAnswers = 0;
  int currentQuestion = 0;
  List<Map<String, dynamic>> questions = [];
  List<int> userAnswer = [];

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

  void checkAnswer() {
    Map<String, dynamic> currentQuestionData = questions[currentQuestion];
    int correctAnswer = currentQuestionData['correctAnswer'];

    int userAnswerNumber = int.parse(userAnswer.join());

    setState(() {
      if (userAnswerNumber == correctAnswer) {
        correctAnswers++;
      } else {
        incorrectAnswers++;
      }
      userAnswer = [];
    });
  }

  void nextQuestion() {
    setState(() {
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
        backgroundColor: Colors.green,
        title: Center(
          child: AnimatedTextKit(
            animatedTexts: [
              FadeAnimatedText(
                'Juego nivel 2',
                textStyle: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
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
            colors: [Colors.green[100]!, Colors.green[400]!],
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
            Text(
              'Tu respuesta: ${userAnswer.join()}',
              style: TextStyle(fontSize: 18.0, color: Colors.black87),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 16.0),
            Wrap(
              spacing: 8.0,
              runSpacing: 8.0,
              children: List.generate(10, (index) {
                return ElevatedButton(
                  onPressed: () {
                    setState(() {
                      userAnswer.add(index);
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white, backgroundColor: Colors.green[700],
                  ),
                  child: Text('$index'),
                );
              }),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                if (userAnswer.isNotEmpty) {
                  checkAnswer();
                  nextQuestion();
                }
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white, backgroundColor: Colors.green[800],
              ),
              child: Text('Enviar Respuesta'),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white, backgroundColor: Colors.grey,
              ),
              child: Text('Regresar'),
            ),
            SizedBox(height: 16.0),
            Expanded(
              child: Center(
                child: Image.asset(
                  'assets/images/animation2.gif',
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
