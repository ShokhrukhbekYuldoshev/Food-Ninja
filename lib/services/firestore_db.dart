// get collection from firestore

import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreDatabase {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  Future<QuerySnapshot> getCollection(String collectionName) async {
    return await _firebaseFirestore.collection(collectionName).get();
  }

  Future<DocumentSnapshot> getDocument(
    String collectionName,
    String documentId,
  ) async {
    return await _firebaseFirestore
        .collection(collectionName)
        .doc(documentId)
        .get();
  }

  Future<void> addDocument(
    String collectionName,
    Map<String, dynamic> data,
  ) async {
    await _firebaseFirestore.collection(collectionName).add(data);
  }

  Future<void> updateDocument(
    String collectionName,
    String documentId,
    Map<String, dynamic> data,
  ) async {
    await _firebaseFirestore
        .collection(collectionName)
        .doc(documentId)
        .update(data);
  }

  Future<void> deleteDocument(
    String collectionName,
    String documentId,
  ) async {
    await _firebaseFirestore
        .collection(collectionName)
        .doc(documentId)
        .delete();
  }

  Future<QuerySnapshot> getCollectionFromReference(
    DocumentReference documentReference,
    String collectionName,
  ) async {
    return await documentReference.collection(collectionName).get();
  }
}
