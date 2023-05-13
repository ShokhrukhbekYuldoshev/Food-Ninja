import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:food_ninja/models/testimonial.dart';

class Restaurant {
  final String name;
  final String location;
  final List<DocumentReference> foodList;
  final DateTime createdAt;
  final List<Testimonial> testimonials;
  final String? image;
  final String? description;

  Restaurant({
    required this.name,
    required this.location,
    required this.foodList,
    required this.createdAt,
    required this.testimonials,
    this.image,
    this.description,
  });

  factory Restaurant.fromMap(Map<String, dynamic> map) {
    return Restaurant(
      name: map['name'],
      image: map['image'],
      location: map['location'],
      description: map['description'],
      foodList: List<DocumentReference>.from(
        map['foodList']?.map(
          (x) => x,
        ),
      ),
      createdAt: map['createdAt'].toDate(),
      testimonials: List<Testimonial>.from(
        map['testimonials']?.map(
              (x) => Testimonial.fromMap(x),
            ) ??
            const [],
      ),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'image': image,
      'location': location,
      'description': description,
      'foodList': foodList,
      'createdAt': createdAt,
      'testimonials': testimonials.map((x) => x.toMap()).toList(),
    };
  }

  // rating is calculated by averaging all the ratings from testimonials
  double get rating {
    if (testimonials.isEmpty) return 0.0;
    return testimonials.map((e) => e.rating).reduce((a, b) => a + b) /
        testimonials.length;
  }
}
