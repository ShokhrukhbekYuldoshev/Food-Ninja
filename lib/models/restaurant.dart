import 'package:cloud_firestore/cloud_firestore.dart';

class Restaurant {
  final String name;
  final String image;
  final double rating;
  final String location;
  final String description;
  final List<DocumentReference> foodList;
  final DateTime createdAt;

  Restaurant({
    required this.name,
    required this.image,
    required this.rating,
    required this.location,
    required this.description,
    required this.foodList,
    required this.createdAt,
  });

  factory Restaurant.fromMap(Map<String, dynamic> map) {
    return Restaurant(
      name: map['name'],
      image: map['image'],
      rating: map['rating'],
      location: map['location'],
      description: map['description'],
      foodList: map['foodList'],
      createdAt: map['createdAt'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'image': image,
      'rating': rating,
      'location': location,
      'description': description,
      'foodList': foodList,
      'createdAt': createdAt,
    };
  }
}
