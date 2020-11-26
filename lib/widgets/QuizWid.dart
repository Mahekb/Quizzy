import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizzy/notifier/quizNotifier.dart';
import 'package:quizzy/screens/ShowQuizScreen.dart';

class QuizWid extends StatefulWidget {
  final dynamic data;
  QuizWid({Key key, this.data}) : super(key: key);

  @override
  _QuestionWidState createState() => _QuestionWidState(data);
}

class _QuestionWidState extends State<QuizWid> {
  _QuestionWidState(data);
  dynamic data;

  @override
  Widget build(BuildContext context) {
    QuizNotifier quizNotifier = Provider.of<QuizNotifier>(context);

    print("\n**********\n");
    print(data);
    print("\n**********\n");
    return Container(
      child: Card(
        clipBehavior: Clip.antiAlias,
        child: Column(
          children: [
            ListTile(
              leading: Icon(Icons.arrow_drop_down_circle),
              title: Text(data["name"] != null ? data["name"] : ""),
              subtitle: Text(
                "No of Questions: " + data["noOfQuestions"].toString() != null
                    ? data["noOfQuestions"].toString()
                    : "",
                style: TextStyle(color: Colors.black.withOpacity(0.6)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Greyhound divisively hello coldly wonderfully marginally far upon excluding.',
                style: TextStyle(color: Colors.black.withOpacity(0.6)),
              ),
            ),
            ButtonBar(
              alignment: MainAxisAlignment.start,
              children: [
                FlatButton(
                  textColor: const Color(0xFF6200EE),
                  onPressed: () {
                    // Quiz quiz =
                    //     Quiz.fromMap(data.data);
                    // quizNotifier.currentQuiz = quiz;
                    quizNotifier.currentQuizId = data["id"];
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ShowQuizScreen()),
                    );
                  },
                  child: const Text('Attempt Quiz'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
