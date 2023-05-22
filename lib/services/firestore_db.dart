import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreDatabase {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  Future<QuerySnapshot> getCollection(String collectionName) async {
    return await _firebaseFirestore.collection(collectionName).get();
  }

  Future<QuerySnapshot> getCollectionWithPagination(
    String collectionName,
    int limit,
    DocumentSnapshot? documentSnapshot,
  ) async {
    if (documentSnapshot == null) {
      return await _firebaseFirestore
          .collection(collectionName)
          .limit(limit)
          .get();
    } else {
      return await _firebaseFirestore
          .collection(collectionName)
          .limit(limit)
          .startAfterDocument(documentSnapshot)
          .get();
    }
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

  // get document from collection where field == value
  Future<QuerySnapshot> getDocumentsWithQuery(
    String collectionName,
    Object field,
    Object value,
  ) async {
    return await _firebaseFirestore
        .collection(collectionName)
        .where(field, isEqualTo: value)
        .get();
  }

  // multiple queries
  Future<QuerySnapshot> getDocumentsWithMultipleQueries(
    String collectionName,
    List<Map<String, dynamic>> where,
  ) async {
    Query query = _firebaseFirestore.collection(collectionName);
    for (var item in where) {
      query = query.where(item['field'], isEqualTo: item['value']);
    }
    return await query.get();
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

  Future<DocumentSnapshot<Object?>> getDocumentFromReference(
    DocumentReference documentReference,
  ) async {
    return await documentReference.get();
  }
}
