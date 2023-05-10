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
