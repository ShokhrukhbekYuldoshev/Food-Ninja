import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:food_ninja/src/data/models/message.dart';
import 'package:hive/hive.dart';

import '../services/firestore_db.dart';

class ChatRepository {
  final FirestoreDatabase _db = FirestoreDatabase();
  var box = Hive.box("myBox");

  Future<Map<String, List<Message>>> fetchChats() async {
    DocumentReference currentUserRef =
        FirebaseFirestore.instance.doc('/users/${box.get('id')}');

    QuerySnapshot<Object?> sentMessagesCollection =
        await _db.getDocumentsWithQuery(
      "messages",
      "sender",
      currentUserRef,
    );
    List<Message> messages = sentMessagesCollection.docs
        .map(
          (snapshot) => Message.fromMap(
            snapshot.data() as Map<String, dynamic>,
          )..id = snapshot.id,
        )
        .toList();

    QuerySnapshot<Object?> receivedMessagesCollection =
        await _db.getDocumentsWithQuery(
      "messages",
      "receiver",
      currentUserRef,
    );

    messages.addAll(
      receivedMessagesCollection.docs
          .map(
            (snapshot) => Message.fromMap(
              snapshot.data() as Map<String, dynamic>,
            )..id = snapshot.id,
          )
          .toList(),
    );

    // sort by date
    messages.sort((a, b) => b.createdAt.compareTo(a.createdAt));

    // group by sender and receiver
    Map<String, List<Message>> groupedMessages = {};
    for (var message in messages) {
      String key1 = message.sender.id + message.receiver.id;
      String key2 = message.receiver.id + message.sender.id;
      if (groupedMessages.containsKey(key1)) {
        groupedMessages[key1]!.add(message);
      } else if (groupedMessages.containsKey(key2)) {
        groupedMessages[key2]!.add(message);
      } else {
        groupedMessages[key1] = [message];
      }
    }

    return groupedMessages;
  }

  // fetch messages between two users
  Future<List<Message>> fetchMessagesBetweenTwoUsers(String otherUserId) async {
    DocumentReference currentUserRef =
        FirebaseFirestore.instance.doc('/users/${box.get('id')}');
    DocumentReference otherUserRef =
        FirebaseFirestore.instance.doc('/users/$otherUserId');

    QuerySnapshot<Object?> sentMessagesCollection =
        await _db.getDocumentsWithMultipleQueries("messages", [
      {
        "field": "sender",
        "value": currentUserRef,
      },
      {
        "field": "receiver",
        "value": otherUserRef,
      },
    ]);

    List<Message> messages = sentMessagesCollection.docs
        .map(
          (snapshot) => Message.fromMap(
            snapshot.data() as Map<String, dynamic>,
          )..id = snapshot.id,
        )
        .toList();

    QuerySnapshot<Object?> receivedMessagesCollection =
        await _db.getDocumentsWithMultipleQueries("messages", [
      {
        "field": "sender",
        "value": otherUserRef,
      },
      {
        "field": "receiver",
        "value": currentUserRef,
      },
    ]);

    messages.addAll(
      receivedMessagesCollection.docs
          .map(
            (snapshot) => Message.fromMap(
              snapshot.data() as Map<String, dynamic>,
            )..id = snapshot.id,
          )
          .toList(),
    );

    // sort by date
    messages.sort((a, b) => b.createdAt.compareTo(a.createdAt));

    return messages;
  }

  Future<void> sendMessage(
    Message message,
  ) async {
    await _db.addDocument("messages", message.toMap());
  }
}
