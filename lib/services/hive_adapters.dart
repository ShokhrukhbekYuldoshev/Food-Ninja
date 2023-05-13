import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive_flutter/adapters.dart';

class FirestoreDocumentReferenceAdapter extends TypeAdapter<DocumentReference> {
  @override
  final int typeId = 0;

  @override
  DocumentReference read(BinaryReader reader) {
    return FirebaseFirestore.instance.doc(reader.read());
  }

  @override
  void write(BinaryWriter writer, DocumentReference obj) {
    writer.write(obj.path);
  }
}
