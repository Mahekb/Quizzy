import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  String id;
  String message;
  String userId;
  Timestamp postedAt;
  Message();

  Message.fromMap(Map<String, dynamic> data) {
    id = data['id'];
    message = data['message'];
    userId = data['userId'];
    postedAt = data['postedAt'];
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'message': message,
      'userId': userId,
      'postedAt': postedAt,
    };
  }
}
