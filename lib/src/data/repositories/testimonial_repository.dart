import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:food_ninja/src/data/models/testimonial.dart';
import 'package:food_ninja/src/data/services/firestore_db.dart';
import 'package:hive/hive.dart';

class TestimonialRepository {
  var box = Hive.box("myBox");
  final FirestoreDatabase _db = FirestoreDatabase();

  Future<void> addTestimonial(
    double rating,
    String review,
    DocumentReference target,
  ) async {
    DocumentReference userRef =
        FirebaseFirestore.instance.doc('/users/${box.get('id')}');

    final Testimonial testimonial =
        Testimonial(review, rating, userRef, DateTime.now(), target);
    await _db.addDocument(
      "testimonials",
      testimonial.toMap(),
    );
  }

  Future<List<Testimonial>> fetchTestimonials(DocumentReference target) async {
    final QuerySnapshot snapshot = await _db.getDocumentsWithQuery(
      "testimonials",
      "target",
      target,
    );
    return snapshot.docs
        .map(
          (QueryDocumentSnapshot doc) => Testimonial.fromMap(
            doc.data() as Map<String, dynamic>,
          ),
        )
        .toList();
  }
}
