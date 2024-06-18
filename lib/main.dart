import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz/state_provider/quiz_model.dart';

import 'package:quiz/view/quiz_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => QuizModel()..fetchQuestions(),
      child: MaterialApp(
        title: 'Quiz App',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: QuizScreen(),
      ),
    );
  }
}
