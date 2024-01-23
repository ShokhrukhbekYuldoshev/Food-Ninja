import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:food_ninja/src/data/models/food.dart';

import '../services/firestore_db.dart';

class FoodRepository {
  final FirestoreDatabase _db = FirestoreDatabase();

  Future<Map<String, Object?>> fetchFoods(int limit, var lastDocument) async {
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

    // check if there are more foods to fetch
    if (foodsCollection.docs.length == limit) {
      return {
        "foods": foods,
        "lastDocument": foodsCollection.docs.last,
      };
    } else {
      return {
        "foods": foods,
        "lastDocument": null,
      };
    }
  }

  // get number of orders for a food
  Future<int> getFoodOrderCount(String foodId) async {
    int count = 0;
    QuerySnapshot<Object?> ordersCollection = await _db.getCollection("orders");

    var data = ordersCollection.docs
        .map((snapshot) => snapshot.data() as Map<String, dynamic>)
        .toList();

    for (var order in data) {
      for (var food in order["cart"]) {
        if (food["id"] == foodId) {
          count += food["quantity"] as int;
        }
      }
    }

    return count;
  }
}
