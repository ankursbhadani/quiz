import 'package:flutter/material.dart';
import '../model/model.dart';

class QuizModel with ChangeNotifier {
  final QuizDataProvider _dataProvider = QuizDataProvider();
  List<Question> _questions = [];
  List<String?> _selectedAnswers = [];
  int _currentQuestionIndex = 0;

  List<Question> get questions => _questions;
  List<String?> get selectedAnswers => _selectedAnswers;
  int get currentQuestionIndex => _currentQuestionIndex;

  void fetchQuestions() async {
    _questions = _dataProvider.getQuestions();
    _selectedAnswers = List.filled(_questions.length, null);
    notifyListeners();
  }

  void selectAnswer(String answer) {
    _selectedAnswers[_currentQuestionIndex] = answer;
    notifyListeners();
  }

  void nextQuestion() {
    if (_currentQuestionIndex < _questions.length - 1) {
      _currentQuestionIndex++;
      notifyListeners();
    }
  }

  void previousQuestion() {
    if (_currentQuestionIndex > 0) {
      _currentQuestionIndex--;
      notifyListeners();
    }
  }

  void restartQuiz() {
    _currentQuestionIndex = 0;
    _selectedAnswers = List.filled(_questions.length, null);
    notifyListeners();
  }
}
