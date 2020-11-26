import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizzy/api/quizApi.dart';
import 'package:quizzy/const/Theme.dart';
import 'package:quizzy/models/Quiz.dart';
import 'package:quizzy/notifier/quizNotifier.dart';
import 'package:quizzy/screens/ResultScreen.dart';
import 'package:quizzy/widgets/QuestionWid.dart';
import 'package:quizzy/widgets/QuizWid.dart';
import 'package:tuple/tuple.dart';

class ShowQuizScreen extends StatefulWidget {
  // String id;
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
  String id;
  final _formKey = GlobalKey<FormState>();
  List<Tuple2<int, int>> ansList = [];
  // final t1 = const Tuple2<String, int>('a', 10);
  // final t2 = t1.withItem1('c');
  @override
  Widget build(BuildContext context) {
    QuizNotifier quizNotifier =
        Provider.of<QuizNotifier>(context, listen: false);
    id = quizNotifier.currentQuizId;
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
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          print("\n*************\n");
          _formKey.currentState.save();
          print(ansList);
          var data = await checkAns(ansList, id);
          print(data.toString());
          print("\n-----------\n");
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => ResultScreen(data: data)),
          );
        },
        child: Icon(Icons.enhanced_encryption),
        backgroundColor: q_PrimaryColor,
      ),
      body: FutureBuilder(
        future: getAllQuestionFromQuiz("userId", id),
        builder: (context, snapshot) {
          if (snapshot.hasError) return Text("Error Occured!");
          if (!snapshot.hasData)
            return Center(
              child: Text("No Question Added"),
            );
          else {
            return Form(
              key: _formKey,
              child: ListView.builder(
                  itemBuilder: (context, index) {
                    return Container(
                      padding: EdgeInsets.symmetric(horizontal: 20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            snapshot.data[index]["questionStatement"] != null
                                ? snapshot.data[index]["questionStatement"]
                                    .toString()
                                : "",
                            style: titleStyle,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            snapshot.data[index]["optionList"][0] != null
                                ? snapshot.data[index]["optionList"][0]
                                    .toString()
                                : "",
                            // style: titleStyle,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            snapshot.data[index]["optionList"][1] != null
                                ? snapshot.data[index]["optionList"][1]
                                    .toString()
                                : "",
                            // style: titleStyle,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            snapshot.data[index]["optionList"][2] != null
                                ? snapshot.data[index]["optionList"][2]
                                    .toString()
                                : "",
                            // style: titleStyle,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            snapshot.data[index]["optionList"][3] != null
                                ? snapshot.data[index]["optionList"][3]
                                    .toString()
                                : "",
                            // style: titleStyle,
                          ),
                          TextFormField(
                            decoration: const InputDecoration(
                              labelText: 'type answer number',
                            ),
                            onSaved: (String value) {
                              int val = int.tryParse(value);

                              bool present = false;
                              for (var ans in ansList) {
                                if (ans.item1 == index) {
                                  present = true;
                                }
                              }
                              if (!present) {
                                final t1 = Tuple2<int, int>(index, val);
                                ansList.add(t1);
                              }
                            },
                            validator: (String value) {
                              if (value.isEmpty) {
                                return 'this is required';
                              }
                            },
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    );
                  },
                  itemCount: snapshot.data.length),
            );
          }
        },
      ),
    );
  }
}
