import 'question.dart';

class QuizBrain {
  int _questionNumber = 0;
  int _points = 0;

  List<Question> _questionBank = [
    Question('O cão de Bianca se chama Gary.', true),
    Question('Bianca gosta de sorvete de creme.', true),
    Question('O animal favorito de Bianca é girafa.', false),
    Question('Bianca ama sushi.', false),
    Question('O desenho favorito de Bianca é Peppa Pig.', true),
  ];

  void nextQuestion() {
    if (_questionNumber < _questionBank.length - 1) {
      _questionNumber++;
    }
  }

  String getQuestionText() {
    return _questionBank[_questionNumber].questionText;
  }

  bool getCorrectAnswer() {
    return _questionBank[_questionNumber].questionAnswer;
  }

  int getLength() {
    return _questionBank.length;
  }

  int getQuestionNumber() {
    return _questionNumber;
  }

  void resetQuestionNumber() {
    _questionNumber = 0;
  }

  int getPoints() {
    return _points;
  }

  void setPoints() {
    _points++;
  }

  void clearPoints() {
    _points = 0;
  }

  bool isFinished() {
    if (_questionNumber == _questionBank.length - 1) {
      return true;
    } else {
      return false;
    }
  }
}
