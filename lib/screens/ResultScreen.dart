import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizzy/api/quizApi.dart';
import 'package:quizzy/const/Theme.dart';
import 'package:quizzy/models/Quiz.dart';
import 'package:quizzy/notifier/quizNotifier.dart';
import 'package:quizzy/widgets/QuestionWid.dart';
import 'package:quizzy/widgets/QuizWid.dart';
import 'package:tuple/tuple.dart';

class ResultScreen extends StatefulWidget {
  dynamic data;
  ResultScreen({Key key, this.data}) : super(key: key);

  @override
  _ResultScreenState createState() => _ResultScreenState(data);
}

class _ResultScreenState extends State<ResultScreen> {
  TextStyle titleStyle = TextStyle(
    fontSize: 17,
    fontWeight: FontWeight.w700,
    color: Colors.black,
  );
  dynamic data;
  String id;

  _ResultScreenState(data);
  @override
  Widget build(BuildContext context) {
    QuizNotifier quizNotifier =
        Provider.of<QuizNotifier>(context, listen: false);
    id = quizNotifier.currentQuizId;
    print("\n***************\n");
    print(widget.data);
    print("\n***************\n");

    return Scaffold(
      appBar: AppBar(
        backgroundColor: q_PrimaryColor,
        elevation: 0,
        title: Text(
          "Result",
          style: TextStyle(
              fontSize: 22.0, fontWeight: FontWeight.bold, letterSpacing: 2),
        ),
      ),
      body: Container(
        padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 5.0),
        child: Column(
          children: [
            Text(
              "Correct Ans: " + widget.data[0].toString(),
            ),
            SizedBox(
              height: 20.0,
            ),
            Text(
              "Wrong Ans: " + widget.data[1].toString(),
            ),
          ],
        ),
      ),
    );
  }
}
