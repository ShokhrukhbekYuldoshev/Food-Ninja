import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:food_ninja/models/food.dart';
import 'package:food_ninja/models/restaurant.dart';
import 'package:food_ninja/services/firestore_db.dart';
part 'restaurant_event.dart';
part 'restaurant_state.dart';

class RestaurantBloc extends Bloc<RestaurantEvent, RestaurantState> {
  RestaurantBloc() : super(RestaurantInitial()) {
    on<RestaurantEvent>((event, emit) {});
    on<LoadRestaurants>((event, emit) async {
      emit(RestaurantLoading());
      try {
        FirestoreDatabase db = FirestoreDatabase();
        QuerySnapshot<Object?> restaurantsCollection =
            await db.getCollectionWithPagination(
          "restaurants",
          event.limit,
          event.lastDocument,
        );

        List<Restaurant> restaurants = restaurantsCollection.docs
            .map(
              (e) => Restaurant.fromMap(e.data() as Map<String, dynamic>),
            )
            .toList();
        emit(
          RestaurantLoaded(restaurants: restaurants),
        );
      } catch (e, s) {
        debugPrint(e.toString());
        debugPrint(s.toString());
        emit(RestaurantError(message: e.toString()));
      }
    });
    on<LoadRestaurantFoods>((event, emit) async {
      emit(RestaurantLoading());
      try {
        List<Food> foods = [];
        for (DocumentReference foodRef in event.foodList) {
          DocumentSnapshot<Object?> foodDoc = await foodRef.get();
          Food food = Food.fromMap(foodDoc.data() as Map<String, dynamic>);
          foods.add(food);
        }
        emit(
          RestaurantFoodsLoaded(foods: foods),
        );
      } catch (e, s) {
        debugPrint(e.toString());
        debugPrint(s.toString());
        emit(RestaurantError(message: e.toString()));
      }
    });
  }
}
