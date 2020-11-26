import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizzy/api/quizApi.dart';
import 'package:quizzy/const/Theme.dart';
import 'package:quizzy/models/Quiz.dart';
import 'package:quizzy/notifier/quizNotifier.dart';
import 'package:quizzy/screens/AddQuestionScreen.dart';

class AddQuizScreen extends StatefulWidget {
  AddQuizScreen({Key key}) : super(key: key);

  @override
  _AddQuizScreenState createState() => _AddQuizScreenState();
}

class _AddQuizScreenState extends State<AddQuizScreen> {
  Quiz _quiz = Quiz();
  TextStyle titleStyle = TextStyle(
    fontSize: 17,
    fontWeight: FontWeight.w700,
    color: Colors.black,
  );
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    QuizNotifier quizNotifier = Provider.of<QuizNotifier>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: q_PrimaryColor,
        elevation: 0,
        title: Text(
          "Add quiz",
          style: TextStyle(
              fontSize: 22.0, fontWeight: FontWeight.bold, letterSpacing: 2),
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Name of the Quiz',
                ),
                onSaved: (String value) {
                  _quiz.name = value;
                },
                validator: (String value) {
                  if (value.isEmpty) {
                    return 'name is required';
                  }
                },
              ),
              SizedBox(
                height: 15.0,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'No. of questions',
                ),
                onSaved: (String value) {
                  _quiz.noOfQuestions = int.tryParse(value);
                },
                validator: (String value) {
                  if (value.isEmpty) {
                    return 'this is required';
                  }
                },
              ),
              SizedBox(
                height: 15.0,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Duration of Quiz',
                ),
                onSaved: (String value) {
                  _quiz.duration = int.tryParse(value);
                },
                validator: (String value) {
                  if (value.isEmpty) {
                    return 'this is required';
                  }
                },
              ),
              SizedBox(
                height: 15.0,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Total Marks',
                ),
                onSaved: (String value) {
                  _quiz.totalMarks = int.tryParse(value);
                },
                validator: (String value) {
                  if (value.isEmpty) {
                    return 'this is required';
                  }
                },
              ),
              SizedBox(
                height: 20.0,
              ),
              RaisedButton(
                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
                onPressed: () async {
                  print("\n*************\n");
                  _formKey.currentState.save();
                  print(_quiz.toMap());
                  print("\n-----------\n");
                  await addQuiz(
                    "userId",
                    _quiz.name,
                    _quiz.noOfQuestions,
                    _quiz.duration,
                    _quiz.totalMarks,
                    _quiz.questionList,
                    _quiz.createdAt,
                  ).then((value) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AddQuestionScreen()),
                    );
                    quizNotifier.currentQuizId = value.toString();
                  });
                },
                child: Text(
                  'Next',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
