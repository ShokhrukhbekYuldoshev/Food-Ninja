part of 'profile_bloc.dart';

@immutable
abstract class ProfileEvent {}

class LoadFavoriteFoods extends ProfileEvent {}

class LoadFavoriteRestaurants extends ProfileEvent {}
