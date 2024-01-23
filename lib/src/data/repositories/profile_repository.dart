import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:food_ninja/src/data/models/food.dart';
import 'package:food_ninja/src/data/models/restaurant.dart';
import 'package:food_ninja/src/data/services/firestore_db.dart';
import 'package:hive/hive.dart';

import '../models/user.dart';

class ProfileRepository {
  final FirestoreDatabase _db = FirestoreDatabase();
  var box = Hive.box('myBox');

  // fetch favorite foods
  Future<List<Food>> fetchFavoriteFoods() async {
    List<DocumentReference> favoriteFoodsReferences =
        User.fromHive().favoriteFoods ?? [];
    List<Food> favoriteFoods = [];
    for (var foodReference in favoriteFoodsReferences) {
      DocumentSnapshot foodSnapshot = await foodReference.get();
      favoriteFoods.add(
        Food.fromMap(
          foodSnapshot.data() as Map<String, dynamic>,
        )..id = foodSnapshot.id,
      );
    }
    return favoriteFoods;
  }

  // fetch favorite restaurants
  Future<List<Restaurant>> fetchFavoriteRestaurants() async {
    List<DocumentReference> favoriteRestaurantsReferences =
        User.fromHive().favoriteRestaurants ?? [];
    List<Restaurant> favoriteRestaurants = [];
    for (var restaurantReference in favoriteRestaurantsReferences) {
      DocumentSnapshot restaurantSnapshot = await restaurantReference.get();
      favoriteRestaurants.add(
        Restaurant.fromMap(
          restaurantSnapshot.data() as Map<String, dynamic>,
        )..id = restaurantSnapshot.id,
      );
    }
    return favoriteRestaurants;
  }

  // add/remove favorite food
  Future<void> toggleFavoriteFood(String foodId) async {
    // get favorite foods from hive
    List favoriteFoods = box.get('favoriteFoods', defaultValue: []);
    DocumentReference foodReference =
        FirebaseFirestore.instance.doc('/foods/$foodId');
    // add/remove food id
    if (!favoriteFoods.contains(foodReference)) {
      favoriteFoods.add(foodReference);
    } else {
      favoriteFoods.remove(foodReference);
    }

    // update firestore
    await _db.updateDocument(
      'users',
      box.get("id"),
      {
        'favoriteFoods': favoriteFoods,
      },
    );

    // update hive
    box.put('favoriteFoods', favoriteFoods);
  }

  // add/remove favorite restaurant
  Future<void> toggleFavoriteRestaurant(String restaurantId) async {
    // get favorite restaurants from hive
    List favoriteRestaurants = box.get('favoriteRestaurants', defaultValue: []);
    DocumentReference restaurantReference =
        FirebaseFirestore.instance.doc('/restaurants/$restaurantId');
    // add/remove restaurant id
    if (!favoriteRestaurants.contains(restaurantReference)) {
      favoriteRestaurants.add(restaurantReference);
    } else {
      favoriteRestaurants.remove(restaurantReference);
    }

    // update firestore
    await _db.updateDocument(
      'users',
      box.get("id"),
      {
        'favoriteRestaurants': favoriteRestaurants,
      },
    );

    // update hive
    box.put('favoriteRestaurants', favoriteRestaurants);
  }
}
