import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizzy/notifier/quizNotifier.dart';
import 'package:quizzy/screens/HomeScreen.dart';
import 'package:quizzy/screens/SignUpScreen.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (context) => QuizNotifier(),
      ),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(),
    );
  }
}
