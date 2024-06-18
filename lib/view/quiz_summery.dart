import 'package:flutter/material.dart';
import '../data/database_helper.dart';
import 'quiz_screen.dart';

class QuizSummaryScreen extends StatefulWidget {
  @override
  _QuizSummaryScreenState createState() => _QuizSummaryScreenState();
}

class _QuizSummaryScreenState extends State<QuizSummaryScreen> {
  Future<List<Map<String, dynamic>>>? _answers;

  @override
  void initState() {
    super.initState();
    _answers = DatabaseHelper().getAnswers();
  }

  void _restartQuiz() async {
    await DatabaseHelper().clearAnswers();
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => QuizScreen()),
          (Route<dynamic> route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz Summary'),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _answers,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No answers found.'));
          } else {
            final answers = snapshot.data!;
            int correctCount = answers.where((answer) => answer['selectedOption'] == answer['correctOption']).length;

            return Column(
              children: [
                Text('Correct Answers: $correctCount / ${answers.length}', style: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
                Expanded(
                  child: ListView.builder(
                    itemCount: answers.length,
                    itemBuilder: (context, index) {
                      final answer = answers[index];
                      final isCorrect = answer['selectedOption'] == answer['correctOption'];
                      return ListTile(
                        title: Text(
                          answer['questionText'],
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(
                          'Selected: ${answer['selectedOption']}',
                          style: TextStyle(color: isCorrect ? Colors.green : Colors.red),
                        ),
                        trailing: Text(
                          'Correct: ${answer['correctOption']}',
                          style: const TextStyle(color: Colors.blue,fontSize: 12),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(height: 16),
                Center(
                  child: ElevatedButton(
                    onPressed: _restartQuiz,
                    child: Text('Restart Quiz'),
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
