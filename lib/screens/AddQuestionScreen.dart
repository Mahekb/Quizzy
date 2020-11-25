import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizzy/api/quizApi.dart';
import 'package:quizzy/const/Theme.dart';
import 'package:quizzy/models/Quiz.dart';
import 'package:quizzy/notifier/quizNotifier.dart';
import 'package:quizzy/screens/ShowQuestionScreen.dart';
import 'package:quizzy/screens/ShowQuizScreen.dart';

class AddQuestionScreen extends StatefulWidget {
  AddQuestionScreen({Key key}) : super(key: key);

  @override
  _AddQuestionScreenState createState() => _AddQuestionScreenState();
}

class _AddQuestionScreenState extends State<AddQuestionScreen> {
  Question _question = Question();
  TextStyle titleStyle = TextStyle(
    fontSize: 17,
    fontWeight: FontWeight.w700,
    color: Colors.black,
  );
  List<String> optionList = [];
  final _formKey = GlobalKey<FormState>();
  int cnt = 1;

  @override
  Widget build(BuildContext context) {
    QuizNotifier quizNotifier = Provider.of<QuizNotifier>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: q_PrimaryColor,
        elevation: 0,
        title: Text(
          "Add question",
          style: TextStyle(
              fontSize: 22.0, fontWeight: FontWeight.bold, letterSpacing: 2),
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Text(
                "Question No. " + cnt.toString(),
                style: TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.w800,
                  color: Colors.black,
                ),
              ),
              SizedBox(
                height: 15.0,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Question',
                ),
                onSaved: (String value) {
                  _question.questionStatement = value;
                },
                validator: (String value) {
                  if (value.isEmpty) {
                    return 'Question is required';
                  }
                },
              ),
              SizedBox(
                height: 15.0,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Option 1',
                ),
                onSaved: (String value) {
                  optionList.add(value);
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
                  labelText: 'Option 2',
                ),
                onSaved: (String value) {
                  optionList.add(value);
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
                  labelText: 'Option 3',
                ),
                onSaved: (String value) {
                  optionList.add(value);
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
                  labelText: 'Option 4',
                ),
                onSaved: (String value) {
                  optionList.add(value);
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
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Correct Option',
                ),
                onSaved: (String value) {
                  _question.correctOption = int.tryParse(value);
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
                  _question.optionList = optionList;
                  print("\n*************\n");
                  _formKey.currentState.save();
                  print(_question.toMap());
                  print("\n-----------\n");
                  await addQuestion(
                    "userId", //here we will have user id from providers
                    quizNotifier.currentQuizId,
                    _question.questionStatement,
                    _question.optionList,
                    _question.correctOption,
                  ).then((value) {
                    _formKey.currentState.reset();
                    optionList.clear();
                    setState(() {
                      cnt += 1;
                    });
                  });
                },
                child: Text(
                  'Add',
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              RaisedButton(
                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ShowQuestionScreen(),
                      // builder: (context) => ShowQuizScreen(),
                    ),
                  );
                },
                child: Text(
                  'View Questions',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
