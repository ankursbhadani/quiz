import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../model/model.dart';
import '../state_provider/quiz_model.dart';

class QuizPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz App'),
      ),
      body: Center(
        child: Consumer<QuizModel>(
          builder: (context, quizModel, child) {
            if (quizModel.questions.isEmpty) {
              return CircularProgressIndicator();
            } else {
              return _buildQuestionPage(context, quizModel);
            }
          },
        ),
      ),
    );
  }

  Widget _buildQuestionPage(BuildContext context, QuizModel quizModel) {
    Question question = quizModel.questions[quizModel.currentQuestionIndex];
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            question.questionText,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20),
          ...question.options.map((option) => RadioListTile<String>(
            title: Text(option),
            value: option,
            groupValue: quizModel.selectedAnswers[quizModel.currentQuestionIndex],
            onChanged: (value) {
              if (value != null) {
                quizModel.selectAnswer(value);
              }
            },
          )),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              quizModel.currentQuestionIndex > 0
                  ? ElevatedButton(
                onPressed: () {
                  quizModel.previousQuestion();
                },
                child: Text("Previous"),
              )
                  : Container(),
              ElevatedButton(
                onPressed: () {
                  if (quizModel.currentQuestionIndex < quizModel.questions.length - 1) {
                    quizModel.nextQuestion();
                  } else {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ResultPage(),
                      ),
                    );
                  }
                },
                child: Text(quizModel.currentQuestionIndex < quizModel.questions.length - 1
                    ? "Next"
                    : "Submit"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class ResultPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final quizModel = Provider.of<QuizModel>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz Result'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Quiz Results',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: quizModel.questions.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(quizModel.questions[index].questionText),
                    subtitle: Text('Your answer: ${quizModel.selectedAnswers[index]}'),
                  );
                },
              ),
            ),
            ElevatedButton(
              onPressed: () {
                quizModel.restartQuiz();
                Navigator.of(context).pop();
              },
              child: const Text("Restart Quiz"),
            ),
          ],
        ),
      ),
    );
  }
}
