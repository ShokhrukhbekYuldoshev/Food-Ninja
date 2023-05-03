import 'package:cloud_firestore/cloud_firestore.dart';

enum PaymentMethod {
  visa,
  paypal;

  String get name {
    switch (this) {
      case PaymentMethod.visa:
        return 'Visa';
      case PaymentMethod.paypal:
        return 'Paypal';
      default:
        return '';
    }
  }
}

class User {
  final String email;
  final String phone;
  final String location;
  final String firstName;
  final String lastName;
  final String image;
  final List<DocumentReference> favoritesFood;
  final List<DocumentReference> favoritesRestaurant;
  final PaymentMethod paymentMethod;
  final DateTime createdAt;

  User({
    required this.email,
    required this.phone,
    required this.location,
    required this.firstName,
    required this.lastName,
    required this.image,
    required this.favoritesFood,
    required this.favoritesRestaurant,
    required this.paymentMethod,
    required this.createdAt,
  });

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      email: map['email'],
      phone: map['phone'],
      location: map['location'],
      firstName: map['firstName'],
      lastName: map['lastName'],
      image: map['image'],
      favoritesFood: map['favoritesFood'],
      favoritesRestaurant: map['favoritesRestaurant'],
      paymentMethod: map['paymentMethod'],
      createdAt: map['createdAt'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'phone': phone,
      'location': location,
      'firstName': firstName,
      'lastName': lastName,
      'image': image,
      'favoritesFood': favoritesFood,
      'favoritesRestaurant': favoritesRestaurant,
      'paymentMethod': paymentMethod,
      'createdAt': createdAt,
    };
  }
}
