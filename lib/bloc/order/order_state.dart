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
  final Order order;
  OrderCreated(
    this.order,
  );
}

class OrderCreatingError extends OrderState {
  final String message;

  OrderCreatingError(this.message);
}

class OrdersFetching extends OrderState {}

class OrdersFetched extends OrderState {
  final List<Order> orders;

  OrdersFetched(this.orders);
}

class OrderFetchingError extends OrderState {
  final String message;

  OrderFetchingError(this.message);
}
