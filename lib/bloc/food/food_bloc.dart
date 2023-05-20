import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:food_ninja/models/food.dart';
import 'package:food_ninja/repositories/food_repository.dart';
part 'food_event.dart';
part 'food_state.dart';

class FoodBloc extends Bloc<FoodEvent, FoodState> {
  final FoodRepository foodRepository = FoodRepository();
  FoodBloc() : super(FoodInitial()) {
    on<FoodEvent>((event, emit) {});
    on<LoadFoods>((event, emit) async {
      emit(FoodLoading());
      try {
        List<Food> foods = await foodRepository.fetchFoods(
          event.limit,
          event.lastDocument,
        );
        emit(
          FoodLoaded(foods: foods),
        );
      } catch (e, s) {
        debugPrint(e.toString());
        debugPrint(s.toString());
        emit(FoodError(message: e.toString()));
      }
    });
    on<SearchFoods>((event, emit) async {
      emit(FoodInitial());
      emit(SearchUpdated());
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
