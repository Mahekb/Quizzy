import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizzy/api/quizApi.dart';
import 'package:quizzy/const/Theme.dart';
import 'package:quizzy/models/Quiz.dart';
import 'package:quizzy/notifier/quizNotifier.dart';
import 'package:quizzy/widgets/QuestionWid.dart';

class ShowQuizScreen extends StatefulWidget {
  ShowQuizScreen({Key key}) : super(key: key);

  @override
  _ShowQuizScreenState createState() => _ShowQuizScreenState();
}

enum SingingCharacter { option1, option2, option3, option4 }

class _ShowQuizScreenState extends State<ShowQuizScreen> {
  TextStyle titleStyle = TextStyle(
    fontSize: 17,
    fontWeight: FontWeight.w700,
    color: Colors.black,
  );
  // SingingCharacter _character = SingingCharacter.option1;
  // var options = <int, int>{
  //   0: 0,
  //   1: 0,
  //   2: 0,
  //   3: 0,
  // };
  @override
  Widget build(BuildContext context) {
    QuizNotifier quizNotifier = Provider.of<QuizNotifier>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: q_PrimaryColor,
        elevation: 0,
        title: Text(
          "Questions",
          style: TextStyle(
              fontSize: 22.0, fontWeight: FontWeight.bold, letterSpacing: 2),
        ),
      ),
      body: FutureBuilder(
        future: getAllQuestionFromQuiz("userId", quizNotifier.currentQuizId),
        builder: (context, snapshot) {
          if (snapshot.hasError) return Text("Error Occured!");
          if (!snapshot.hasData)
            return Center(
              child: Text("No Question Added"),
            );
          else {
            return ListView.builder(
                itemBuilder: (context, index) {
                  return QuestionWid(
                    data: snapshot.data[index].data,
                  );
                },
                itemCount: snapshot.data.length);
          }
        },
      ),
    );
  }
}
