part of 'restaurant_bloc.dart';

@immutable
abstract class RestaurantEvent {}

class LoadRestaurants extends RestaurantEvent {
  // limit, lastDocument
  final int limit;
  final DocumentSnapshot? lastDocument;

  LoadRestaurants({
    required this.limit,
    required this.lastDocument,
  });
}

class LoadRestaurantFoods extends RestaurantEvent {
  final String restaurantId;

  LoadRestaurantFoods({required this.restaurantId});
}

class SearchRestaurants extends RestaurantEvent {}

class FetchOrderCount extends RestaurantEvent {
  final String restaurantId;

  FetchOrderCount({required this.restaurantId});
}
