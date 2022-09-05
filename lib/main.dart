import 'package:flutter/material.dart';
import 'QuizBrain.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

QuizBrain quizbrain = QuizBrain();
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
  @override
  int suc = 0;
  void fire_Alert(int suc) {
    Alert(
      context: context,
      type: AlertType.success,
      title: "Quiz Finished",
      desc: "You get out $suc of 12 questions",
      buttons: [
        DialogButton(
          child: Text(
            "OK",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () => Navigator.pop(context),
          width: 120,
        )
      ],
    ).show();
  }

  List<Icon> checker = [];
  int c = 0;
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
                quizbrain.Questions[c].text,
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
              textColor: Colors.white,
              color: Colors.green,
              child: Text(
                'True',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
              onPressed: () {
                setState(() {
                  if (quizbrain.Questions[c].acul_ans == true) {
                    checker.add(Icon(Icons.check, color: Colors.green));
                    suc++;
                  } else
                    checker.add(Icon(Icons.close, color: Colors.red));
                  c++;
                  if (c == quizbrain.Questions.length) {
                    fire_Alert(suc);
                    checker.clear();
                    c = 0;
                  }
                });
                //The user picked true.
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
                setState(() {
                  if (quizbrain.Questions[c].acul_ans == false) {
                    checker.add(Icon(Icons.check, color: Colors.green));
                    suc++;
                  } else
                    checker.add(Icon(Icons.close, color: Colors.red));
                  c++;
                  if (c == quizbrain.Questions.length) {
                    fire_Alert(suc);
                    checker.clear();
                    c = 0;
                  }
                });
                //The user picked false.
              },
            ),
          ),
        ),
        Row(children: checker)
      ],
    );
  }
}
