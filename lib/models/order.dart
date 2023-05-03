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
  final double total;
  final DocumentReference restaurant;
  final DocumentReference user;
  final OrderStatus status;
  final DateTime createdAt;

  Order({
    required this.foodList,
    required this.total,
    required this.restaurant,
    required this.user,
    required this.status,
    required this.createdAt,
  });

  factory Order.fromMap(Map<String, dynamic> map) {
    return Order(
      foodList: map['foodList'],
      total: map['total'],
      restaurant: map['restaurant'],
      user: map['user'],
      status: map['status'],
      createdAt: map['createdAt'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'foodList': foodList,
      'total': total,
      'restaurant': restaurant,
      'user': user,
      'status': status,
      'createdAt': createdAt,
    };
  }
}
