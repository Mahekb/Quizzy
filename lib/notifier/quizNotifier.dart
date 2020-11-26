import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:quizzy/models/Quiz.dart';

class QuizNotifier with ChangeNotifier {
  Quiz _currentQuiz;
  String _currentQuizId;
  String get currentQuizId => _currentQuizId;
  Quiz get currentQuiz => _currentQuiz;

  // String _currentQuizAns;

  set currentQuiz(Quiz quiz) {
    _currentQuiz = quiz;
    _currentQuizId = quiz.id;
    notifyListeners();
  }

  set currentQuizId(String currentQuizId) {
    _currentQuizId = currentQuizId;
    notifyListeners();
  }
}
