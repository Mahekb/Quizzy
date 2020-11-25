import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quizzy/screens/SearchScreen.dart';
import 'MessageRoom.dart';

class Person {
  String na;
  String url;
  Person(String na, String url) {
    this.na = na;
    this.url = url;
  }
}

class MessageScreen extends StatefulWidget {
  @override
  _MessageScreenState createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  String name;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quizzy'),
      ),
      body: StreamBuilder(
        stream: Firestore.instance
            .collection('users/usaZr853aYY12kS96irQ/chats')
            .snapshots(),
        builder: (context, streamSnapshot) {
          return ListView.builder(
              itemCount: streamSnapshot.data.documents.length,
              itemBuilder: (BuildContext ctxt, int index) {
                return new InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MessageRoom(
                              name: streamSnapshot.data.documents[index]
                                  ['username'],
                              url: streamSnapshot.data.documents[index]
                                  ['url'])),
                    );
                  },
                  child: Container(
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      color: Colors.grey[350],
                      elevation: 5,
                      child: Row(
                        children: [
                          Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Image.network(
                                  streamSnapshot.data.documents[index]['url'],
                                  width: 40,
                                  height: 40)),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                streamSnapshot.data.documents[index]
                                    ['chatswith'],
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                              Text(
                                "Your Message",
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.black.withOpacity(0.6),
                                ),
                              ), //Text
                            ],
                          ), //Column
                        ],
                      ), //Row
                    ), //Card
                  ), //Container
                );
              });
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: IconButton(
          icon: Icon(Icons.add),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SearchScreen()),
            );
          },
        ),
      ),
    );
  }
}
