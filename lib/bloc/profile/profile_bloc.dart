import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:food_ninja/models/food.dart';
import 'package:food_ninja/models/restaurant.dart';

import '../../models/user.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileInitial()) {
    on<ProfileEvent>((event, emit) {});
    on<LoadFavoriteFoods>((event, emit) async {
      emit(FavoriteFoodsLoading());
      try {
        List<DocumentReference> favoriteFoodsReferences =
            User.fromHive().favoriteFoods ?? [];
        List<Food> favoriteFoods = [];
        for (var foodReference in favoriteFoodsReferences) {
          DocumentSnapshot foodSnapshot = await foodReference.get();
          favoriteFoods.add(
            Food.fromMap(
              foodSnapshot.data() as Map<String, dynamic>,
            ),
          );
        }
        emit(FavoriteFoodsLoaded(favoriteFoods: favoriteFoods));
      } catch (e) {
        emit(ProfileError(message: e.toString()));
      }
    });
    on<LoadFavoriteRestaurants>((event, emit) async {
      emit(FavoriteRestaurantsLoading());
      try {
        List<DocumentReference> favoriteRestaurantsReferences =
            User.fromHive().favoriteRestaurants ?? [];
        List<Restaurant> favoriteRestaurants = [];
        for (var restaurantReference in favoriteRestaurantsReferences) {
          DocumentSnapshot restaurantSnapshot = await restaurantReference.get();
          favoriteRestaurants.add(
            Restaurant.fromMap(
              restaurantSnapshot.data() as Map<String, dynamic>,
            ),
          );
        }
        emit(
          FavoriteRestaurantsLoaded(
            favoriteRestaurants: favoriteRestaurants,
          ),
        );
      } catch (e, s) {
        debugPrint(e.toString());
        debugPrint(s.toString());
        emit(ProfileError(message: e.toString()));
      }
    });
  }
}
