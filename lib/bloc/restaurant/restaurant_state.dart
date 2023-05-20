part of 'restaurant_bloc.dart';

@immutable
abstract class RestaurantState {}

class RestaurantInitial extends RestaurantState {}

class RestaurantsLoading extends RestaurantState {}

class RestaurantsLoaded extends RestaurantState {
  final List<Restaurant> restaurants;

  RestaurantsLoaded({required this.restaurants});
}

class RestaurantsLoadingError extends RestaurantState {
  final String message;

  RestaurantsLoadingError({required this.message});
}

class RestaurantFoodsLoaded extends RestaurantState {
  final List<Food> foods;

  RestaurantFoodsLoaded({required this.foods});
}

class RestaurantFoodsError extends RestaurantState {
  final String message;

  RestaurantFoodsError({required this.message});
}

class SearchUpdated extends RestaurantState {
  SearchUpdated();
}
