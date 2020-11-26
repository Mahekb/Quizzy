import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizzy/api/quizApi.dart';
import 'package:quizzy/const/Theme.dart';
import 'package:quizzy/models/Quiz.dart';
import 'package:quizzy/notifier/quizNotifier.dart';
import 'package:quizzy/screens/AddQuizScreen.dart';
import 'package:quizzy/screens/MessageScreen.dart';
import 'package:quizzy/screens/ShowQuizScreen.dart';
import 'package:quizzy/screens/SignUpScreen.dart';

class AllQuizesScreen extends StatefulWidget {
  AllQuizesScreen({Key key}) : super(key: key);

  @override
  _AllQuizesScreenState createState() => _AllQuizesScreenState();
}

class _AllQuizesScreenState extends State<AllQuizesScreen> {
  TextStyle noStyle = TextStyle(
    fontSize: 35,
    fontWeight: FontWeight.bold,
    color: q_green,
  );

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
        title: Text(
          "Quizzy",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: FutureBuilder(
        future: getAllQuiz("userId"),
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
                      Card(
                        clipBehavior: Clip.antiAlias,
                        child: Column(
                          children: [
                            ListTile(
                              leading: Icon(Icons.arrow_drop_down_circle),
                              title: Text(snapshot.data[index]["name"] != null
                                  ? snapshot.data[index]["name"]
                                  : ""),
                              subtitle: Text(
                                "No of Questions: " +
                                            snapshot.data[index]
                                                    ["noOfQuestions"]
                                                .toString() !=
                                        null
                                    ? snapshot.data[index]["noOfQuestions"]
                                        .toString()
                                    : "",
                                style: TextStyle(
                                    color: Colors.black.withOpacity(0.6)),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Text(
                                'Greyhound divisively hello coldly wonderfully marginally far upon excluding.',
                                style: TextStyle(
                                    color: Colors.black.withOpacity(0.6)),
                              ),
                            ),
                            ButtonBar(
                              alignment: MainAxisAlignment.start,
                              children: [
                                FlatButton(
                                  textColor: const Color(0xFF6200EE),
                                  onPressed: () async {
                                    // Quiz quiz =
                                    //     Quiz.fromMap(snapshot.data[index].data);
                                    // quizNotifier.currentQuiz = quiz;
                                    quizNotifier.currentQuizId =
                                        snapshot.data[index]["id"];
                                    print("\n---------------------------\n");
                                    print(quizNotifier.currentQuizId);
                                    print("\n---------------------------\n");

                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              ShowQuizScreen()),
                                    );
                                  },
                                  child: const Text('Attempt Quiz'),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
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
