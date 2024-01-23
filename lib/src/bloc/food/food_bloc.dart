import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:food_ninja/src/data/models/food.dart';
import 'package:food_ninja/src/data/repositories/food_repository.dart';
part 'food_event.dart';
part 'food_state.dart';

class FoodBloc extends Bloc<FoodEvent, FoodState> {
  final FoodRepository foodRepository = FoodRepository();
  FoodBloc() : super(FoodInitial()) {
    on<FoodEvent>((event, emit) {});
    on<LoadFoods>((event, emit) async {
      emit(FoodFetching());
      try {
        Map<String, dynamic> map = await foodRepository.fetchFoods(
          event.limit,
          event.lastDocument,
        );
        emit(
          FoodFetched(
            foods: map["foods"] as List<Food>,
            lastDocument: map["lastDocument"] as DocumentSnapshot?,
          ),
        );
      } catch (e, s) {
        debugPrint(e.toString());
        debugPrint(s.toString());
        emit(FoodError(message: e.toString()));
      }
    });
    on<FetchMoreFoods>((event, emit) async {
      emit(FoodMoreFetching());
      try {
        Map<String, dynamic> map = await foodRepository.fetchFoods(
          event.limit,
          event.lastDocument,
        );
        emit(
          FoodMoreFetched(
            foods: map["foods"] as List<Food>,
            lastDocument: map["lastDocument"] as DocumentSnapshot?,
          ),
        );
      } catch (e, s) {
        debugPrint(e.toString());
        debugPrint(s.toString());
        emit(FoodError(message: e.toString()));
      }
    });
    on<QueryFoods>((event, emit) async {
      emit(FoodInitial());
      emit(QueryUpdated());
    });
    on<FetchOrderCount>((event, emit) async {
      emit(OrderCountFetching());
      try {
        int count = await foodRepository.getFoodOrderCount(event.foodId);
        emit(OrderCountFetched(count: count));
      } catch (e, s) {
        debugPrint(e.toString());
        debugPrint(s.toString());
        emit(OrderCountError(message: e.toString()));
      }
    });
  }
}
