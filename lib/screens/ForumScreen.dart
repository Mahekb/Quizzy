import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizzy/api/quizApi.dart';
import 'package:quizzy/const/Theme.dart';
import 'package:quizzy/models/Quiz.dart';
import 'package:quizzy/notifier/authNotifier.dart';
import 'package:quizzy/notifier/authNotifier.dart';
import 'package:quizzy/notifier/quizNotifier.dart';

class ForumScreen extends StatefulWidget {
  ForumScreen({Key key}) : super(key: key);

  @override
  _ForumScreenState createState() => _ForumScreenState();
}

class _ForumScreenState extends State<ForumScreen> {
  TextStyle titleStyle = TextStyle(
    fontSize: 17,
    fontWeight: FontWeight.w700,
    color: Colors.black,
  );
  final TextEditingController textEditingController =
      new TextEditingController();

  @override
  Widget build(BuildContext context) {
    AuthNotifier authNotifier = Provider.of<AuthNotifier>(context);
    QuizNotifier quizNotifier = Provider.of<QuizNotifier>(context);

    return Scaffold(
        appBar: AppBar(
          backgroundColor: q_PrimaryColor,
          elevation: 0,
          title: Text(
            "Forum",
            style: TextStyle(
                fontSize: 22.0, fontWeight: FontWeight.bold, letterSpacing: 2),
          ),
        ),
        body: Column(
          children: [
            Container(
              child: Row(
                children: <Widget>[
                  Flexible(
                    child: Container(
                      child: TextField(
                        style: TextStyle(color: Colors.black, fontSize: 15.0),
                        controller: textEditingController,
                        decoration: InputDecoration.collapsed(
                          hintText: 'Type a message',
                          hintStyle: TextStyle(color: Colors.black),
                        ),
                      ),
                    ),
                  ),

                  // Send Message Button
                  Material(
                    child: new Container(
                      margin: new EdgeInsets.symmetric(horizontal: 8.0),
                      child: new IconButton(
                        icon: new Icon(Icons.send),
                        onPressed: () async {
                          await addMessage(authNotifier.userId,
                              textEditingController.text.toString());
                          textEditingController.clear();
                        },
                        color: q_PrimaryColor,
                      ),
                    ),
                    color: Colors.white,
                  ),
                ],
              ),
              width: double.infinity,
              height: 50.0,
            ),
            StreamBuilder(
              stream: Firestore.instance
                  .collection("messages/")
                  .orderBy("postedAt")
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasError) return Text("Error");
                if (!snapshot.hasData) return Text("Loading ....");

                return ListView.builder(
                    shrinkWrap: true,
                    itemBuilder: (_, int index) {
                      return Column(
                        children: [
                          Text(
                            snapshot.data.documents[index]["message"],
                            style: titleStyle,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                        ],
                      );
                    },
                    itemCount: snapshot.data.documents.length,
                    // reverse: true,
                    padding: EdgeInsets.all(6.0));
              },
            ),
          ],
        ));
  }
}
