import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'MessageRoom.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String searchKey;
  Stream streamQuery;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          TextField(
            onChanged: (value) {
              setState(() {
                searchKey = value;
                streamQuery = Firestore.instance
                    .collection('Users')
                    .where('username', isGreaterThanOrEqualTo: searchKey)
                    .where('username', isLessThan: searchKey + 'z')
                    .snapshots();
              });
            },
            decoration: InputDecoration(
              hintText: 'Search username',
              icon: Icon(Icons.search),
            ),
          ),
          StreamBuilder(
              stream: streamQuery,
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
                                        streamSnapshot.data.documents[index]
                                            ['url'],
                                        width: 40,
                                        height: 40)),
                                Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      streamSnapshot.data.documents[index]
                                          ['username'],
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
              })
        ],
      ),
    );
  }
}
