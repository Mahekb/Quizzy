import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizzy/notifier/authNotifier.dart';
import 'package:quizzy/notifier/quizNotifier.dart';
import 'package:quizzy/screens/HomeScreen.dart';
import 'package:quizzy/screens/MessageScreen.dart';
import 'package:quizzy/screens/SignUpScreen.dart';
import 'package:quizzy/screens/login.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (context) => AuthNotifier(),
      ),
      ChangeNotifierProvider(
        create: (context) => QuizNotifier(),
      ),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Consumer<AuthNotifier>(
        builder: (context, notifier, child) {
          return notifier.user != null ? HomeScreen() : Login();
        },
      ),
    );
  }
}
