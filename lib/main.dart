import 'package:flutter/material.dart';
import 'quiz_brain.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

QuizBrain quizBrain = QuizBrain();

void main() => runApp(BiancaQuiz());

class BiancaQuiz extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue.shade800,
          title: Text(
            'Bianca\'s Quiz',
            style: TextStyle(fontSize: 20.0, color: Colors.white),
          ),
        ),
        backgroundColor: Colors.blue.shade900,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: QuizPage(),
          ),
        ),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  List<Icon> scoreKeeper = [];

  void checkEnd() {
    if (quizBrain.isFinished() == true) {
      Alert(
        context: context,
        type: AlertType.info,
        title: 'O QUIZ CHEGOU AO FIM',
        desc:
            'Sua pontuação foi: ${quizBrain.getPoints()}/${quizBrain.getLength()}',
        buttons: [
          DialogButton(
            width: 200.0,
            child: Text(
              "JOGAR NOVAMENTE",
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
            onPressed: () {
              Navigator.pop(context);
              setState(
                () {
                  quizBrain.resetQuestionNumber();
                  scoreKeeper.clear();
                  quizBrain.clearPoints();
                },
              );
            },
          ),
        ],
      ).show();
    } else {
      quizBrain.nextQuestion();
    }
  }

  void checkAnswer(bool userPickedAnswer) {
    bool correctAnswer = quizBrain.getCorrectAnswer();

    setState(
      () {
        if (userPickedAnswer == correctAnswer) {
          scoreKeeper.add(Icon(Icons.check, color: Colors.green));
          quizBrain.setPoints();
        } else {
          scoreKeeper.add(Icon(Icons.close, color: Colors.red));
        }
        checkEnd();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          flex: 5,
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                quizBrain.getQuestionText(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 30.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: FlatButton(
                textColor: Colors.white,
                color: Colors.green,
                child: Text(
                  'Certo',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25.0,
                  ),
                ),
                onPressed: () {
                  checkAnswer(true);
                }),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: FlatButton(
              color: Colors.red,
              child: Text(
                'Errado',
                style: TextStyle(
                  fontSize: 25.0,
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                checkAnswer(false);
              },
            ),
          ),
        ),
        Row(
          children: scoreKeeper,
        )
      ],
    );
  }
}
