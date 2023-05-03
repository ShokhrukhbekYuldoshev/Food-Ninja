import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  final DocumentReference receiver;
  final DocumentReference sender;
  final String text;
  final DateTime createdAt;

  Message({
    required this.receiver,
    required this.sender,
    required this.text,
    required this.createdAt,
  });

  factory Message.fromMap(Map<String, dynamic> map) {
    return Message(
      receiver: map['receiver'],
      sender: map['sender'],
      text: map['text'],
      createdAt: map['createdAt'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'receiver': receiver,
      'sender': sender,
      'text': text,
      'createdAt': createdAt,
    };
  }
}
