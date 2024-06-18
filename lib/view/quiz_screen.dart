import 'package:flutter/material.dart';
import 'package:quiz/view/quiz_summery.dart';
import '../model/model.dart';
import '../data/database_helper.dart';

class QuizScreen extends StatefulWidget {
  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  final QuizDataProvider _quizDataProvider = QuizDataProvider();
  List<Question> _questions = [];
  int _currentQuestionIndex = 0;
  List<Answer> _answers = [];
  String? _selectedOption;

  @override
  void initState() {
    super.initState();
    _startNewQuiz();
  }

  Future<void> _startNewQuiz() async {
    await DatabaseHelper().clearAnswers();//for clear previous record
    setState(() {
      _questions = _quizDataProvider.getQuestions();// getting questions from data provider
      _currentQuestionIndex = 0;
      _answers.clear();
      _selectedOption = null;
    });
  }

  void _submitAnswer() {
    if (_selectedOption != null) {
      final currentQuestion = _questions[_currentQuestionIndex];
      final answer = Answer(currentQuestion, _selectedOption!);
      _answers.add(answer);
      DatabaseHelper().insertAnswer(answer);
    }
  }

  void _nextQuestion() {
    if (_selectedOption != null) {
      _submitAnswer();

      if (_currentQuestionIndex < _questions.length - 1) {
        setState(() {
          _currentQuestionIndex++;
          _selectedOption = null;
        });
      } else {
        _finishQuiz();
      }
    } else {
      // Show a message if no option is selected
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select an answer before proceeding')),
      );
    }
  }

  void _finishQuiz() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => QuizSummaryScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Check if _questions is empty
    if (_questions.isEmpty) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Quiz'),
        ),
        body: const Center(
          child: Text('No questions available.'),
        ),
      );
    }

    final currentQuestion = _questions[_currentQuestionIndex];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(currentQuestion.questionText, style: TextStyle(fontSize: 18)),
            const SizedBox(height: 16),
            ...currentQuestion.options.map((option) => ListTile(
              title: Text(option),
              leading: Radio<String>(
                value: option,
                groupValue: _selectedOption,
                onChanged: (value) {
                  setState(() {
                    _selectedOption = value;
                  });
                },
              ),
            )),
            const SizedBox(height: 16),
            Center(
              child: ElevatedButton(
                onPressed: _nextQuestion,
                child: _currentQuestionIndex < _questions.length - 1 ? Text('Next') : Text('Finish Quiz'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
