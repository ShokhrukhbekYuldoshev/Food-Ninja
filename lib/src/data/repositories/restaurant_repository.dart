import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:food_ninja/src/data/models/food.dart';
import 'package:food_ninja/src/data/models/restaurant.dart';
import 'package:food_ninja/src/data/services/firestore_db.dart';

class RestaurantRepository {
  final FirestoreDatabase _db = FirestoreDatabase();
  Future<List<Restaurant>> fetchRestaurants(int limit, var lastDocument) async {
    QuerySnapshot<Object?> restaurantsCollection =
        await _db.getCollectionWithPagination(
      "restaurants",
      limit,
      lastDocument,
    );

    List<Restaurant> restaurants = restaurantsCollection.docs
        .map(
          (e) =>
              Restaurant.fromMap(e.data() as Map<String, dynamic>)..id = e.id,
        )
        .toList();

    // sort by date
    restaurants.sort((a, b) => b.createdAt.compareTo(a.createdAt));

    return restaurants;
  }

  Future<List<Food>> fetchRestaurantFoods(String restaurantId) async {
    DocumentReference restaurantRef =
        FirebaseFirestore.instance.collection("restaurants").doc(restaurantId);
    var snapshot = await _db.getDocumentsWithQuery(
      "foods",
      "restaurant",
      restaurantRef,
    );

    List<Food> foods = snapshot.docs
        .map(
          (e) => Food.fromMap(e.data() as Map<String, dynamic>)..id = e.id,
        )
        .toList();

    // sort by date
    foods.sort((a, b) => b.createdAt.compareTo(a.createdAt));

    return foods;
  }

  Future<int> getRestaurantOrderCount(String restaurantId) async {
    // get number of orders for a food
    int count = 0;
    QuerySnapshot<Object?> ordersCollection = await _db.getCollection("orders");

    var data = ordersCollection.docs
        .map((snapshot) => snapshot.data() as Map<String, dynamic>)
        .toList();

    for (var order in data) {
      DocumentReference restaurantRef = order["restaurant"];
      if (restaurantRef.path.endsWith(restaurantId)) {
        count += 1;
      }
    }

    return count;
  }
}
