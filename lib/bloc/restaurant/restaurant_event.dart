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
