import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'HomeScreen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String _email, _password;
  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quizzy'),
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.fromLTRB(5, 30, 0, 0),
            child: Text('Welcome to ',
                style: TextStyle(
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                    // foreground: Paint()..shader = linearGradient,
                    fontStyle: FontStyle.italic)),
          ),
          Container(
            width: 225,
            height: 140,
            decoration: BoxDecoration(
                border: Border.all(
                    width: 8, color: Theme.of(context).scaffoldBackgroundColor),
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(
                      "https://cdn.ilovefreesoftware.com/wp-content/uploads/2016/03/quizzlyfeatured.png",
                    ))),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(hintText: 'Email'),
                onChanged: (value) {
                  setState(() {
                    _email = value.trim();
                  });
                }),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              obscureText: true,
              decoration: InputDecoration(hintText: 'password'),
              onChanged: (value) {
                setState(() {
                  _password = value.trim();
                });
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              RaisedButton(
                color: Theme.of(context).accentColor,
                child: Text('Login'),
                onPressed: () {
                  auth.signInWithEmailAndPassword(
                      email: _email, password: _password);
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => HomeScreen(),
                  ));
                },
              ),
              RaisedButton(
                color: Theme.of(context).accentColor,
                child: Text('Signup'),
                onPressed: () {
                  auth.createUserWithEmailAndPassword(
                      email: _email, password: _password);

                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => HomeScreen(),
                  ));
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}
