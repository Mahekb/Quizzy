import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:quizzy/models/Quiz.dart';
import 'package:provider/provider.dart';
import 'package:quizzy/notifier/quizNotifier.dart';

Future<String> addQuiz(
    String userId,
    String name,
    int noOfQuestions,
    int duration,
    int totalMarks,
    List<String> questionList,
    Timestamp createdAt) async {
  //creating quiz
  DocumentReference ref = Firestore.instance.collection("quiz").document();
  String id = ref.documentID;
  Quiz quiz = Quiz();
  quiz.id = id;
  quiz.name = name;
  quiz.noOfQuestions = noOfQuestions;
  quiz.duration = duration;
  quiz.totalMarks = totalMarks;
  quiz.questionList = questionList;
  quiz.createdAt = Timestamp.now();

  try {
    await ref.setData(quiz.toMap());
    return id;
  } catch (err) {
    print("Error While adding quiz: $err");
    return null;
  }
}

//add question in quiz
Future<bool> addQuestion(String userId, String quizId, String questionStatement,
    List<String> optionList, int correctOption) async {
  DocumentReference ref =
      Firestore.instance.collection("quiz/$quizId/questions").document();
  String id = ref.documentID;
  Question question = Question();
  question.id = id;
  question.quizId = quizId;
  question.questionStatement = questionStatement;
  question.correctOption = correctOption;
  question.optionList = optionList;

  try {
    await ref.setData(question.toMap());
    return true;
  } catch (err) {
    print("Error While adding question: $err");
    return false;
  }
}

Future<List<DocumentSnapshot>> getAllQuestionFromQuiz(
    String userId, String quizId) async {
  try {
    CollectionReference ref =
        Firestore.instance.collection("quiz/$quizId/questions");
    var snapshots = await ref.getDocuments();
    return snapshots.documents;
  } catch (err) {
    print("erro : $err");
    return null;
  }
}
