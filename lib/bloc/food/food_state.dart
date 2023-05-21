part of 'food_bloc.dart';

@immutable
abstract class FoodState {}

class FoodInitial extends FoodState {}

class FoodLoading extends FoodState {}

class FoodLoaded extends FoodState {
  final List<Food> foods;
  final DocumentSnapshot? lastDocument;

  FoodLoaded({required this.foods, required this.lastDocument});
}

class FoodMoreFetched extends FoodState {
  final List<Food> foods;
  final DocumentSnapshot? lastDocument;

  FoodMoreFetched({required this.foods, required this.lastDocument});
}

class FoodMoreFetching extends FoodState {}

class FoodError extends FoodState {
  final String message;

  FoodError({required this.message});
}

class SearchUpdated extends FoodState {
  SearchUpdated();
}

class OrderCountFetching extends FoodState {}

class OrderCountError extends FoodState {
  final String message;

  OrderCountError({required this.message});
}

class OrderCountFetched extends FoodState {
  final int count;

  OrderCountFetched({required this.count});
}
