import 'dart:math';
import 'package:flutter/material.dart';

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
        title: Text('Game'),
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
            if (userAnswer != null)
              Text(
                'Your answer: $userAnswer\nCorrect answer: ${currentQuestionData['correctAnswer']}',
                style: TextStyle(fontSize: 18.0),
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
                        title: Text('Submit Answer'),
                        content: TextField(
                          keyboardType: TextInputType.number,
                          onSubmitted: (value) {
                            checkAnswer(int.parse(value));
                            Navigator.pop(context);
                          },
                          decoration: InputDecoration(
                            hintText: 'Enter your answer',
                          ),
                        ),
                      );
                    },
                  );
                } else {
                  nextQuestion();
                }
              },
              child: Text(userAnswer == null ? 'Submit Answer' : 'Next'),
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