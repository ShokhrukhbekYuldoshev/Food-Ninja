import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:food_ninja/src/data/models/food.dart';
import 'package:food_ninja/src/data/models/restaurant.dart';
import 'package:food_ninja/src/data/repositories/restaurant_repository.dart';
part 'restaurant_event.dart';
part 'restaurant_state.dart';

class RestaurantBloc extends Bloc<RestaurantEvent, RestaurantState> {
  final RestaurantRepository restaurantRepository = RestaurantRepository();
  RestaurantBloc() : super(RestaurantInitial()) {
    on<RestaurantEvent>((event, emit) {});
    on<LoadRestaurants>((event, emit) async {
      emit(RestaurantsLoading());
      try {
        List<Restaurant> restaurants = await restaurantRepository
            .fetchRestaurants(event.limit, event.lastDocument);
        emit(
          RestaurantsLoaded(restaurants: restaurants),
        );
      } catch (e, s) {
        debugPrint(e.toString());
        debugPrint(s.toString());
        emit(RestaurantsLoadingError(message: e.toString()));
      }
    });
    on<LoadRestaurantFoods>((event, emit) async {
      emit(RestaurantFoodsLoading());
      try {
        List<Food> foods =
            await restaurantRepository.fetchRestaurantFoods(event.restaurantId);
        emit(
          RestaurantFoodsLoaded(foods: foods),
        );
      } catch (e, s) {
        debugPrint(e.toString());
        debugPrint(s.toString());
        emit(RestaurantFoodsError(message: e.toString()));
      }
    });
    on<SearchRestaurants>((event, emit) async {
      emit(RestaurantInitial());
      emit(SearchUpdated());
    });
    on<FetchOrderCount>((event, emit) async {
      emit(OrderCountFetching());
      try {
        int count = await restaurantRepository
            .getRestaurantOrderCount(event.restaurantId);

        emit(OrderCountFetched(count: count));
      } catch (e, s) {
        debugPrint(e.toString());
        debugPrint(s.toString());
        emit(OrderCountError(message: e.toString()));
      }
    });
  }
}
