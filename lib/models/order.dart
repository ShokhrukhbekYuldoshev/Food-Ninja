import 'package:cloud_firestore/cloud_firestore.dart';

enum OrderStatus {
  pending,
  preparing,
  delivering,
  delivered,
  canceled,
}

class Order {
  final List<DocumentReference> foodList;
  final double subtotal;
  final double deliveryFee;
  final double discount;
  final double total;
  final DocumentReference restaurant;
  final DocumentReference user;
  final OrderStatus status;
  final DateTime createdAt;

  Order({
    required this.foodList,
    required this.subtotal,
    required this.deliveryFee,
    required this.discount,
    required this.total,
    required this.restaurant,
    required this.user,
    required this.status,
    required this.createdAt,
  });

  factory Order.fromMap(Map<String, dynamic> map) {
    return Order(
      foodList: map['foodList'],
      subtotal: map['subtotal'] * 1.0,
      deliveryFee: map['deliveryFee'] * 1.0,
      discount: map['discount'] * 1.0,
      total: map['total'] * 1.0,
      restaurant: map['restaurant'],
      user: map['user'],
      status: map['status'],
      createdAt: map['createdAt'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'foodList': foodList,
      'subtotal': subtotal,
      'deliveryFee': deliveryFee,
      'discount': discount,
      'total': total,
      'restaurant': restaurant,
      'user': user,
      'status': status,
      'createdAt': createdAt,
    };
  }
}
