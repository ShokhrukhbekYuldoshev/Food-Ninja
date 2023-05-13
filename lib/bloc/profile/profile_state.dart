part of 'profile_bloc.dart';

@immutable
abstract class ProfileState {}

class ProfileInitial extends ProfileState {}

class FavoriteFoodsLoading extends ProfileState {}

class FavoriteRestaurantsLoading extends ProfileState {}

class FavoriteFoodsLoaded extends ProfileState {
  final List<Food> favoriteFoods;

  FavoriteFoodsLoaded({
    required this.favoriteFoods,
  });
}

class FavoriteRestaurantsLoaded extends ProfileState {
  final List<Restaurant> favoriteRestaurants;

  FavoriteRestaurantsLoaded({
    required this.favoriteRestaurants,
  });
}

class ProfileError extends ProfileState {
  final String message;

  ProfileError({
    required this.message,
  });
}
