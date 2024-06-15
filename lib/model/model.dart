class Question {
  final String questionText;
  final List<String> options;

  Question(this.questionText, this.options);
}

class Answer {
  final Question question;
  final String selectedOption;

  Answer(this.question, this.selectedOption);
}

class QuizDataProvider {
  List<Question> getQuestions() {
    return [
      Question("What is the capital of France?", ["Paris", "London"]),
      Question("What is 2 + 2?", ["4", "5"]),
      Question("In which year did World War II end?", ["1945", "1947"]),
      Question("Who wrote “Romeo and Juliet?", ["William Shakespeare", "William gems"]),
      Question("What is the largest planet in our solar system?", ["Jupiter", "Sun"]),
      Question("In which year did the Titanic sink?", ["1914", "1992"]),
      Question("What is the largest desert in the world?", ["Sahara Desert", "Antarctica"]),
      Question("Who was the first woman to win a Nobel Prize?", [" Marie Curie", "Maria Mayer"]),
    ];
  }
}
