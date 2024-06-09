import 'dart:math';
import 'package:flutter/material.dart';

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
          questionText = 'How many hundreds are in $number?';
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
          questionText = 'How many tens are in $number?';
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
          questionText = 'How many ones are in $number?';
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
              title: Text('Game Over'),
              content: Text(
                'Correct Answers: $correctAnswers\nIncorrect Answers: $incorrectAnswers',
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
                  child: Text('Go Back'),
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
        title: Text('Didactic Game'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Correct: $correctAnswers',
                  style: TextStyle(fontSize: 18.0),
                ),
                Text(
                  'Incorrect: $incorrectAnswers',
                  style: TextStyle(fontSize: 18.0),
                ),
              ],
            ),
            SizedBox(height: 16.0),
            Text(
              'Question ${currentQuestion + 1}:',
              style: TextStyle(fontSize: 24.0),
            ),
            SizedBox(height: 16.0),
            Text(
              currentQuestionData['questionText'],
              style: TextStyle(fontSize: 24.0),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 32.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 50.0,
                  height: 50.0,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                  ),
                  child: Center(
                    child: Text(
                      '${currentQuestionData['hundreds']}',
                      style: TextStyle(fontSize: 24.0),
                    ),
                  ),
                ),
                SizedBox(width: 8.0),
                Container(
                  width: 50.0,
                  height: 50.0,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                  ),
                  child: Center(
                    child: Text(
                      '${currentQuestionData['tens']}',
                      style: TextStyle(fontSize: 24.0),
                    ),
                  ),
                ),
                SizedBox(width: 8.0),
                Container(
                  width: 50.0,
                  height: 50.0,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                  ),
                  child: Center(
                    child: Text(
                      '${currentQuestionData['ones']}',
                      style: TextStyle(fontSize: 24.0),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 32.0),
            Text(
              'Your answer: ${userAnswer.join()}',
              style: TextStyle(fontSize: 18.0),
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
              child: Text('Submit Answer'),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Go Back'),
            ),
          ],
        ),
      ),
    );
  }
}
