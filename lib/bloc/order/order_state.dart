part of 'order_bloc.dart';

@immutable
abstract class OrderState {}

class OrderInitial extends OrderState {}

class UIUpdated extends OrderState {
  UIUpdated();
}

class CartUpdated extends OrderState {
  final List<Food> cart;

  CartUpdated(this.cart);
}

class OrderCreating extends OrderState {}

class OrderCreated extends OrderState {
  OrderCreated();
}

class OrderError extends OrderState {
  final String message;

  OrderError(this.message);
}
