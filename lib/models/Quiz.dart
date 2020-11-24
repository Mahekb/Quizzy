import 'package:cloud_firestore/cloud_firestore.dart';

class Quiz {
  String id;
  String name;
  int noOfQuestions;
  int duration;
  int totalMarks;
  List<String> questionList;
  Timestamp createdAt;
  Quiz();

  Quiz.fromMap(Map<String, dynamic> data) {
    id = data['id'];
    name = data['name'];
    noOfQuestions = data['noOfQuestions'];
    duration = data['duration'];
    totalMarks = data['totalMarks'];
    questionList = List.from(data['questionList']);
    createdAt = data['createdAt'];
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'noOfQuestions': noOfQuestions,
      'duration': duration,
      'totalMarks': totalMarks,
      'questionList': questionList,
      'createdAt': createdAt,
    };
  }
}

class Question {
  Question();
  String id;
  String quizId;
  String questionStatement;
  List<String> optionList;
  int correctOption;

  Question.fromMap(Map<String, dynamic> data) {
    id = data["id"];
    questionStatement = data["questionStatement"];
    optionList = List.from(data["optionList"]);
    correctOption = data["correctOption"];
    quizId = data["quizId"];
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "questionStatement": questionStatement,
      "optionList": optionList,
      "correctOption": correctOption,
      "quizId": quizId,
    };
  }
}
