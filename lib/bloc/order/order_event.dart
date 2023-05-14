part of 'order_bloc.dart';

@immutable
abstract class OrderEvent {}

class AddToCart extends OrderEvent {
  final Food food;

  AddToCart(this.food);
}

class RemoveFromCart extends OrderEvent {
  final Food food;

  RemoveFromCart(this.food);
}

class RemoveCompletelyFromCart extends OrderEvent {
  final Food food;

  RemoveCompletelyFromCart(this.food);
}
