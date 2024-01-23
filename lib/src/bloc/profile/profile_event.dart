part of 'profile_bloc.dart';

@immutable
abstract class ProfileEvent {}

class FetchFavorites extends ProfileEvent {}

class ToggleFavoriteFood extends ProfileEvent {
  final String foodId;

  ToggleFavoriteFood({required this.foodId});
}

class ToggleFavoriteRestaurant extends ProfileEvent {
  final String restaurantId;

  ToggleFavoriteRestaurant({required this.restaurantId});
}
