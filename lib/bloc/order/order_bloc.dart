import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:food_ninja/models/food.dart';
import 'package:food_ninja/repositories/order_repository.dart';

part 'order_event.dart';
part 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  final OrderRepository orderRepository = OrderRepository();
  OrderBloc() : super(OrderInitial()) {
    on<OrderEvent>((event, emit) {});
    on<AddToCart>((event, emit) {
      emit(OrderInitial());
      orderRepository.addToCart(event.food);
      emit(CartUpdated(OrderRepository.cart));
    });
    on<RemoveFromCart>((event, emit) {
      emit(OrderInitial());
      orderRepository.removeFromCart(event.food);
      emit(CartUpdated(OrderRepository.cart));
    });
    on<RemoveCompletelyFromCart>((event, emit) {
      emit(OrderInitial());
      orderRepository.removeCompletelyFromCart(event.food);
      emit(CartUpdated(OrderRepository.cart));
    });
  }
}
