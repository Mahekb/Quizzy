import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizzy/api/quizApi.dart';
import 'package:quizzy/const/Theme.dart';
import 'package:quizzy/models/Quiz.dart';
import 'package:quizzy/notifier/quizNotifier.dart';

class ShowQuestionScreen extends StatefulWidget {
  ShowQuestionScreen({Key key}) : super(key: key);

  @override
  _ShowQuestionScreenState createState() => _ShowQuestionScreenState();
}

class _ShowQuestionScreenState extends State<ShowQuestionScreen> {
  TextStyle titleStyle = TextStyle(
    fontSize: 17,
    fontWeight: FontWeight.w700,
    color: Colors.black,
  );

  @override
  Widget build(BuildContext context) {
    QuizNotifier quizNotifier = Provider.of<QuizNotifier>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: q_PrimaryColor,
        elevation: 0,
        title: Text(
          "Your Questions",
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
                  return Column(
                    children: [
                      Text(
                        snapshot.data[index]["questionStatement"],
                        style: titleStyle,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text("option 0:" + snapshot.data[index]["optionList"][0]),
                      SizedBox(
                        height: 10,
                      ),
                      Text("option 1:" + snapshot.data[index]["optionList"][1]),
                      SizedBox(
                        height: 10,
                      ),
                      Text("option 2:" + snapshot.data[index]["optionList"][2]),
                      SizedBox(
                        height: 10,
                      ),
                      Text("option 3:" + snapshot.data[index]["optionList"][3]),
                      SizedBox(
                        height: 10,
                      ),
                      Text("correct option" +
                          snapshot.data[index]["correctOption"].toString()),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  );
                },
                itemCount: snapshot.data.length);
          }
        },
      ),
    );
  }
}
