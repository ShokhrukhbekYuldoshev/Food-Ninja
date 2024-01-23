import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:food_ninja/src/data/models/food.dart';
import 'package:food_ninja/src/data/models/order_status.dart';
import 'package:food_ninja/src/data/models/payment_method.dart';

// ignore: must_be_immutable
class Order extends Equatable {
  final List<Food> cart;
  final double subtotal;
  final double deliveryFee;
  final double discount;
  final double total;
  final DocumentReference restaurant;
  final String userEmail;
  final OrderStatus status;
  final DateTime createdAt;
  final PaymentMethod paymentMethod;

  // id is the document id
  String? id;

  Order({
    required this.cart,
    required this.subtotal,
    required this.deliveryFee,
    required this.discount,
    required this.total,
    required this.restaurant,
    required this.userEmail,
    required this.status,
    required this.createdAt,
    required this.paymentMethod,
  });

  factory Order.fromMap(Map<String, dynamic> map) {
    return Order(
      cart: List<Food>.from(map['cart']?.map((x) => Food.fromMap(x)) ?? []),
      subtotal: map['subtotal'] * 1.0,
      deliveryFee: map['deliveryFee'] * 1.0,
      discount: map['discount'] * 1.0,
      total: map['total'] * 1.0,
      restaurant: map['restaurant'],
      userEmail: map['userEmail'],
      status: OrderStatus.values[map['status']],
      createdAt: map['createdAt'].toDate(),
      paymentMethod: PaymentMethod.values[map['paymentMethod']],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'cart': cart.map(
        (x) {
          var food = x.toMap();
          food['quantity'] = x.quantity;
          return food;
        },
      ).toList(),
      'subtotal': subtotal,
      'deliveryFee': deliveryFee,
      'discount': discount,
      'total': total,
      'restaurant': restaurant,
      'userEmail': userEmail,
      'status': status.index,
      'createdAt': createdAt,
      'paymentMethod': paymentMethod.index,
    };
  }

  @override
  List<Object?> get props => [
        id,
        cart,
        subtotal,
        deliveryFee,
        discount,
        total,
        restaurant,
        userEmail,
        status,
        createdAt,
        paymentMethod,
      ];
}
