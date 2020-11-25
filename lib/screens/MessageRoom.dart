import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MessageRoom extends StatefulWidget {
  MessageRoom({Key key, this.name, this.url}) : super(key: key);
  final String name;
  final String url;
  @override
  _MessageRoomState createState() => _MessageRoomState();
}

class _MessageRoomState extends State<MessageRoom> {
  final myController = TextEditingController();
  var _sendMessage;
  final myUserId = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(children: [
          IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => Navigator.of(context).pop(),
          ),
          Image.network(widget.url, width: 40, height: 40),
          Padding(
            padding: EdgeInsets.all(10.0),
            child: Text(widget.name),
          ),
        ]),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(
            child: StreamBuilder(
              stream: Firestore.instance
                  .collection(
                      'users/usaZr853aYY12kS96irQ/chats/ECWUt92FzEyE4e6J5Yaj/messages')
                  .orderBy('createdAt', descending: true)
                  .snapshots(),
              builder: (ctxt, streamSnapshot) {
                return ListView.builder(
                  itemCount: streamSnapshot.data.documents.length,
                  itemBuilder: (ctxt, index) {
                    return Expanded(
                      child: Align(
                        alignment: streamSnapshot.data.documents[index]
                                ['isSent']
                            ? Alignment.centerRight
                            : Alignment.centerLeft,
                        child: Container(
                          padding: EdgeInsets.all(10.0),
                          color: Colors.grey[350],
                          child: Text(
                            streamSnapshot.data.documents[index]['content'],
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: myController,
                  textInputAction: TextInputAction.send,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) {
                    setState(() {
                      _sendMessage = value;
                    });
                  },
                ),
              ),
              IconButton(
                icon: Icon(Icons.send),
                color: Colors.black,
                onPressed: () async {
                  if (_sendMessage.trim().isEmpty) {
                    return null;
                  }
                  FocusScope.of(context).unfocus();

                  Firestore.instance
                      .collection(
                          'users/usaZr853aYY12kS96irQ/chats/ECWUt92FzEyE4e6J5Yaj/messages')
                      .add({
                    'content': _sendMessage,
                    'time': Timestamp.now(),
                  });
                  myController.clear();
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
