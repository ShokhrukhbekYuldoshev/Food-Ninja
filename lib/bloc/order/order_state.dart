part of 'order_bloc.dart';

@immutable
abstract class OrderState {}

class OrderInitial extends OrderState {}

class CartUpdated extends OrderState {
  final List<Food> cart;

  CartUpdated(this.cart);
}
