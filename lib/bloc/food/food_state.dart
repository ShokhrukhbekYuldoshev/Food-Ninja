part of 'food_bloc.dart';

@immutable
abstract class FoodState {}

class FoodInitial extends FoodState {}

class FoodLoading extends FoodState {}

class FoodLoaded extends FoodState {
  final List<Food> foods;

  FoodLoaded({required this.foods});
}

class FoodError extends FoodState {
  final String message;

  FoodError({required this.message});
}
