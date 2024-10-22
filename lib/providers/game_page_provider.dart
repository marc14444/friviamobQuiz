import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class GamePageProvider extends ChangeNotifier {
  final Dio _dio = Dio();
  final int _maxquestions = 10;
  final String difficultyLevel;


  List? questions;
  int _currentQuestionCount = 0;
  int _correctCount = 0;

  BuildContext context;
  GamePageProvider({required this.context, required this.difficultyLevel}) {
    _dio.options.baseUrl = 'https://opentdb.com/api.php';
    _getQuestionsFromAPI();
    print('Hello');
  }
  Future<void> _getQuestionsFromAPI() async {
    print(difficultyLevel);
    var _response = await _dio.get(
      '',
      queryParameters: {
        'amount': 10,
        'difficulty': difficultyLevel,
        'type': 'boolean',
      },
    );
    var _data = jsonDecode(_response.toString());
    questions = _data['results'];
    notifyListeners();
    print(_data);
  }

  String getCurrentQuestiontext() {
    return questions![_currentQuestionCount]['question'];
  }

  void answerQuestion(String _answer) async {
    bool isCorrect =
        questions![_currentQuestionCount]["correct_answer"] == _answer;
    _correctCount += isCorrect ? 1 : 0; 
    _currentQuestionCount++;
    print(isCorrect ? "correct" : "Incorrect");
    showDialog(
        context: context,
        builder: (BuildContext _context) {
          return AlertDialog(
            backgroundColor: isCorrect ? Colors.green : Colors.red,
            title: Icon(
              isCorrect ? Icons.check_circle : Icons.cancel_sharp,
              color: Colors.white,
            ),
          );
        });
    await Future.delayed(
      const Duration(seconds: 1),
    );
    Navigator.pop(context);
    if(_currentQuestionCount == _maxquestions){
      endGame();
    }else{
    notifyListeners();
    }
  }

  Future<void> endGame() async {
    showDialog(
        context: context,
        builder: (BuildContext _context) {
          return AlertDialog(
            backgroundColor: Colors.blue,
            title: const Text(
              "End Game!",
              style: TextStyle(fontSize: 25, color: Colors.white),
            ),
            content: Text("Score: $_correctCount/$_maxquestions"),
          );
        },
    );
    await Future.delayed(
      const Duration(seconds: 3),
    );
    Navigator.pop(context);
    Navigator.pop(context); 
  }
}
