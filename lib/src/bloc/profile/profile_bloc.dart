import 'package:bloc/bloc.dart';

import 'package:flutter/foundation.dart';
import 'package:food_ninja/src/data/models/food.dart';
import 'package:food_ninja/src/data/models/restaurant.dart';
import 'package:food_ninja/src/data/repositories/profile_repository.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final ProfileRepository profileRepository = ProfileRepository();
  ProfileBloc() : super(ProfileInitial()) {
    on<ProfileEvent>((event, emit) {});
    on<FetchFavorites>((event, emit) async {
      emit(FetchingFavorites());
      try {
        List<Food> favoriteFoods = await profileRepository.fetchFavoriteFoods();
        List<Restaurant> favoriteRestaurants =
            await profileRepository.fetchFavoriteRestaurants();
        emit(
          FavoritesFetched(
            favoriteFoods: favoriteFoods,
            favoriteRestaurants: favoriteRestaurants,
          ),
        );
      } catch (e, s) {
        debugPrint(e.toString());
        debugPrint(s.toString());
        emit(ProfileError(message: e.toString()));
      }
    });

    on<ToggleFavoriteFood>((event, emit) async {
      try {
        emit(ProfileInitial());
        await profileRepository.toggleFavoriteFood(event.foodId);
        emit(FavoriteFoodToggled());
      } catch (e, s) {
        debugPrint(e.toString());
        debugPrint(s.toString());
        emit(ProfileError(message: e.toString()));
      }
    });
    on<ToggleFavoriteRestaurant>((event, emit) async {
      try {
        emit(ProfileInitial());
        await profileRepository.toggleFavoriteRestaurant(event.restaurantId);
        emit(FavoriteRestaurantToggled());
      } catch (e, s) {
        debugPrint(e.toString());
        debugPrint(s.toString());
        emit(ProfileError(message: e.toString()));
      }
    });
  }
}
