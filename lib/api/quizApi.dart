import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:quizzy/models/Message.dart';
import 'package:quizzy/models/Quiz.dart';
import 'package:provider/provider.dart';
import 'package:quizzy/models/User.dart';
import 'package:quizzy/notifier/authNotifier.dart';
import 'package:quizzy/notifier/quizNotifier.dart';
import 'package:tuple/tuple.dart';

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

Future<List<DocumentSnapshot>> getAllQuiz(String userId) async {
  try {
    CollectionReference ref = Firestore.instance.collection("quiz/");
    var snapshots = await ref.getDocuments();
    return snapshots.documents;
  } catch (err) {
    print("erro : $err");
    return null;
  }
}

Future<bool> enableQuiz(String quizId, context) async {
  QuizNotifier quizNotifier = Provider.of<QuizNotifier>(context);
  quizNotifier.currentQuizId = quizId;
}

Future<void> initializeCurrentUser(AuthNotifier authNotifier) async {
  FirebaseUser firebaseUser = await FirebaseAuth.instance.currentUser();
  print("authnotifier initialization !! : $firebaseUser");

  if (firebaseUser != null) {
    print(firebaseUser);
    authNotifier.setUser(firebaseUser);
    var ref =
        await Firestore.instance.document("users/${firebaseUser.uid}").get();

    authNotifier.name = ref.data["name"];
    authNotifier.email = ref.data["email"];
  }
}

Future<String> login(User user, AuthNotifier authNotifier) async {
  String errorCode;
  AuthResult authResult = await FirebaseAuth.instance
      .signInWithEmailAndPassword(email: user.email, password: user.password)
      .catchError((error) {
    print("Error code: ${error.code}");
    errorCode = error.code.toString();
  });

  if (authResult != null) {
    FirebaseUser firebaseUser = authResult.user;

    if (firebaseUser != null) {
      print("Log In: $firebaseUser");
      authNotifier.setUser(firebaseUser);
      return "True";
    }
  }
  return errorCode;
}

Future<String> signup(User user, AuthNotifier authNotifier) async {
  String errorCode;
  AuthResult authResult = await FirebaseAuth.instance
      .createUserWithEmailAndPassword(
          email: user.email, password: user.password)
      .catchError((error) {
    errorCode = error.code.toString();
    print(error.code);
  });

  if (authResult != null) {
    await Firestore.instance
        .collection('users')
        .document(authResult.user.uid)
        .setData({}, merge: true).then((value) async {
      print("resgisterd succesfully");
      FirebaseUser currentUser = await FirebaseAuth.instance.currentUser();
      authNotifier.setUser(currentUser);
    }).catchError((err) {
      errorCode = err.toString();
      print("got error $err");
    });
    return "True";
  }
  return errorCode;
}

signout(AuthNotifier authNotifier) async {
  try {
    await FirebaseAuth.instance
        .signOut()
        .catchError((error) => print("Error code : ${error.code}"));
    authNotifier.currentUser(null);
  } catch (err) {
    print("Error : $err");
  }
}

checkAns(List<Tuple2<int, int>> ansList, String quizId) async {
  try {
    CollectionReference ref =
        Firestore.instance.collection("quiz/$quizId/questions");
    var snapshots = await ref.getDocuments();
    int correct = 0, wrong = 0;
    List<int> ans = [];
    for (var i = 0; i < snapshots.documents.length; i++) {
      if (ansList[i].item2 == snapshots.documents[i]["correctOption"]) {
        correct += 1;
      } else {
        wrong += 1;
      }
    }
    ans.add(correct);
    ans.add(wrong);
    return ans;
  } catch (err) {
    print("erro : $err");
    return null;
  }
}

Future<List<DocumentSnapshot>> getAllMessages(String userId) async {
  try {
    CollectionReference ref = Firestore.instance.collection("messages/");
    var snapshots = await ref.getDocuments();
    return snapshots.documents;
  } catch (err) {
    print("erro : $err");
    return null;
  }
}

Future<String> addMessage(String userId, String messagee) async {
  DocumentReference ref = Firestore.instance.collection("messages").document();
  String id = ref.documentID;
  Message message = Message();
  message.id = id;
  message.userId = userId;
  message.message = messagee;
  message.postedAt = Timestamp.now();

  try {
    await ref.setData(message.toMap());
    return id;
  } catch (err) {
    print("Error While adding message: $err");
    return null;
  }
}
