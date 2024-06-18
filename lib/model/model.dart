class Question {
  final String questionText;
  final List<String> options;
  final String correctAnswer;

  Question(this.questionText, this.options, this.correctAnswer);
}


class Answer {
  final Question question;
  final String selectedOption;

  Answer(this.question, this.selectedOption);

  String get correctOption => question.correctAnswer;
}

class QuizDataProvider {
  List<Question> getQuestions() {
    return [
      Question("What is the capital of France?", ["Paris", "London"], "Paris"),
      Question("What is 2 + 2?", ["4", "5"], "4"),
      Question("In which year did World War II end?", ["1945", "1947"], "1945"),
      Question("Who wrote “Romeo and Juliet?", ["William Shakespeare", "William gems"], "William Shakespeare"),
      Question("What is the largest planet in our solar system?", ["Jupiter", "Sun"], "Jupiter"),
      Question("In which year did the Titanic sink?", ["1914", "1992"], "1914"),
      Question("What is the largest desert in the world?", ["Sahara Desert", "Antarctica"], "Antarctica"),
      Question("Who was the first woman to win a Nobel Prize?", ["Marie Curie", "Maria Mayer"], "Marie Curie"),
    ];
  }
}
