import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:food_ninja/models/food.dart';

import '../services/firestore_db.dart';

class FoodRepository {
  final FirestoreDatabase _db = FirestoreDatabase();

  Future<List<Food>> fetchFoods(int limit, var lastDocument) async {
    QuerySnapshot<Object?> foodsCollection =
        await _db.getCollectionWithPagination(
      "foods",
      limit,
      lastDocument,
    );

    // id is the document id
    List<Food> foods = foodsCollection.docs
        .map(
          (snapshot) => Food.fromMap(
            snapshot.data() as Map<String, dynamic>,
          )..id = snapshot.id,
        )
        .toList();

    // sort by date
    foods.sort((a, b) => b.createdAt.compareTo(a.createdAt));

    return foods;
  }
}
