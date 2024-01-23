import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class Message extends Equatable {
  final DocumentReference receiver;
  final DocumentReference sender;
  final String text;
  final DateTime createdAt;
  String? id;
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
      createdAt: map['createdAt'].toDate(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'receiver': receiver,
      'sender': sender,
      'text': text,
      'createdAt': createdAt,
    };
  }

  @override
  List<Object?> get props => [receiver, sender, text, createdAt];
}
