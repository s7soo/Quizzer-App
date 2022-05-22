import 'package:flutter/material.dart';
import 'package:quizzer_app/QuizBrain.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

void main() => runApp(Quizzler());

class Quizzler extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey.shade900,
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

  List<Icon> scorekeeper = [
  ];

  void checkAnswer(bool answer) {
    bool correctanswer = quizBrain.getQuestionAnswer();

    if (quizBrain.isFinished() == true) {
      Alert(context: context, title: "Quzzier", desc: "End of quiz").show();
      setState(() {
        quizBrain.setQuestionNumber();
        scorekeeper = [];
      });
    }
    else {
      if (correctanswer == answer)
        scorekeeper.add(
            Icon(
              Icons.check, color: Colors.green,
            )
        );
      else
        scorekeeper.add(
            Icon(
              Icons.close, color: Colors.red,
            )
        );
      setState(() {
        quizBrain.nextQuestion();
      });
    }
  }
  QuizBrain quizBrain = QuizBrain();

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
                // quizBrain.questionBank[questionNumber].qusetionText,
                quizBrain.getQuestiontext(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25.0,
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
              color: Colors.green,
              child: Text(
                'True',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
              onPressed: () {
                // bool correctanswer = quizBrain.questionBank[questionNumber].questionAnswer;
                checkAnswer(true);

              },
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: FlatButton(
              color: Colors.red,
              child: Text(
                'False',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                checkAnswer(false);
                // bool correctanswer = quizBrain.questionBank[questionNumber].questionAnswer;
              },
            ),
          ),
        ),
        Row(
          children: scorekeeper,
        )
      ],
    );
  }
}

