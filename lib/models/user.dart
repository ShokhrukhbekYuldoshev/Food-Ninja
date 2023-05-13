import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive/hive.dart';

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
      favoritesFood: List<DocumentReference>.from(
        map['favoritesFood']?.map(
          (x) => x,
        ),
      ),
      favoritesRestaurant: List<DocumentReference>.from(
        map['favoritesRestaurant']?.map((x) => x),
      ),
      paymentMethod: map['paymentMethod'] == 'visa'
          ? PaymentMethod.visa
          : PaymentMethod.paypal,
      createdAt: map['createdAt'].toDate(),
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
      'paymentMethod': paymentMethod.name,
      'createdAt': createdAt,
    };
  }

  factory User.fromHive() {
    var box = Hive.box('myBox');
    return User(
      email: box.get('email', defaultValue: ''),
      phone: box.get('phone', defaultValue: ''),
      location: box.get('location', defaultValue: ''),
      firstName: box.get('firstName', defaultValue: ''),
      lastName: box.get('lastName', defaultValue: ''),
      image: box.get('image', defaultValue: ''),
      favoritesFood: box.get(
        'favoritesFood',
        defaultValue: List<DocumentReference>.empty(),
      ),
      favoritesRestaurant: box.get(
        'favoritesRestaurant',
        defaultValue: List<DocumentReference>.empty(),
      ),
      paymentMethod: box.get('paymentMethod', defaultValue: 'visa') == 'visa'
          ? PaymentMethod.visa
          : PaymentMethod.paypal,
      createdAt: box.get('createdAt', defaultValue: DateTime.now()),
    );
  }

  Future<void> saveToHive() async {
    var box = Hive.box('myBox');

    box.put('email', email);
    box.put('phone', phone);
    box.put('location', location);
    box.put('firstName', firstName);
    box.put('lastName', lastName);
    box.put('image', image);
    box.put('favoritesFood', favoritesFood);
    box.put('favoritesRestaurant', favoritesRestaurant);
    box.put('paymentMethod', paymentMethod.name);
    box.put('createdAt', createdAt);
  }

  String get fullName => '$firstName $lastName';
  String get initials => '${firstName[0]}${lastName[0]}';
}
