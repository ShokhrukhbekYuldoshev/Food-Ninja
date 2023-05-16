part of 'restaurant_bloc.dart';

@immutable
abstract class RestaurantState {}

class RestaurantInitial extends RestaurantState {}

class RestaurantLoading extends RestaurantState {}

class RestaurantLoaded extends RestaurantState {
  final List<Restaurant> restaurants;

  RestaurantLoaded({required this.restaurants});
}

class RestaurantError extends RestaurantState {
  final String message;

  RestaurantError({required this.message});
}

class RestaurantFoodsLoaded extends RestaurantState {
  final List<Food> foods;

  RestaurantFoodsLoaded({required this.foods});
}

class RestaurantFoodsError extends RestaurantState {
  final String message;

  RestaurantFoodsError({required this.message});
}
