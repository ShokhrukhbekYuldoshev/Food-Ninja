part of 'profile_bloc.dart';

@immutable
abstract class ProfileState {}

class ProfileInitial extends ProfileState {}

class FetchingFavorites extends ProfileState {}

class FavoritesFetched extends ProfileState {
  final List<Food> favoriteFoods;
  final List<Restaurant> favoriteRestaurants;

  FavoritesFetched({
    required this.favoriteFoods,
    required this.favoriteRestaurants,
  });
}

class ProfileError extends ProfileState {
  final String message;

  ProfileError({
    required this.message,
  });
}

class FavoriteFoodToggled extends ProfileState {}

class FavoriteRestaurantToggled extends ProfileState {}
