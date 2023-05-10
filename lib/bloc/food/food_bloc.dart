import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:food_ninja/models/food.dart';
import 'package:food_ninja/services/firestore_db.dart';
part 'food_event.dart';
part 'food_state.dart';

class FoodBloc extends Bloc<FoodEvent, FoodState> {
  FoodBloc() : super(FoodInitial()) {
    on<FoodEvent>((event, emit) {});
    on<LoadFoods>((event, emit) async {
      emit(FoodLoading());
      try {
        FirestoreDatabase db = FirestoreDatabase();
        QuerySnapshot<Object?> foodsCollection =
            await db.getCollectionWithPagination(
          "foods",
          event.limit,
          event.lastDocument,
        );

        List<Food> foods = foodsCollection.docs
            .map(
              (e) => Food.fromMap(e.data() as Map<String, dynamic>),
            )
            .toList();
        emit(
          FoodLoaded(foods: foods),
        );
      } catch (e, s) {
        debugPrint(e.toString());
        debugPrint(s.toString());
        emit(FoodError(message: e.toString()));
      }
    });
  }
}
