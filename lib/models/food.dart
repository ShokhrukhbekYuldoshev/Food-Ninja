import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

import 'package:food_ninja/models/testimonial.dart';

class Food {
  final String? image;
  final DocumentReference category;
  final DocumentReference restaurant;
  final String name;
  final double price;
  final List<String> ingredients;
  final DateTime createdAt;
  final String? description;
  final double? discount;
  final List<Testimonial> testimonials;

  // for cart
  int quantity = 0;

  Food({
    required this.image,
    required this.category,
    required this.restaurant,
    required this.name,
    required this.price,
    required this.ingredients,
    required this.createdAt,
    this.discount,
    this.description,
    required this.testimonials,
  });

  factory Food.fromMap(Map<String, dynamic> map) {
    return Food(
      image: map['image'],
      category: map['category'],
      restaurant: map['restaurant'],
      name: map['name'],
      price: map['price'] * 1.0,
      ingredients: List<String>.from(map['ingredients'] ?? const []),
      createdAt: map['createdAt'].toDate(),
      discount: map['discount'] * 1.0 ?? 0.0,
      description: map['description'],
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
      'image': image,
      'category': category,
      'restaurant': restaurant,
      'name': name,
      'price': price,
      'ingredients': ingredients,
      'createdAt': createdAt,
      'discount': discount ?? 0.0,
      'description': description ?? '',
      'testimonials': testimonials.map((x) => x.toMap()).toList(),
    };
  }

  // rating is calculated by averaging all the ratings from testimonials
  double get rating {
    if (testimonials.isEmpty) return 0.0;
    return testimonials.map((e) => e.rating).reduce((a, b) => a + b) /
        testimonials.length;
  }

  @override
  bool operator ==(covariant Food other) {
    if (identical(this, other)) return true;

    return other.image == image &&
        other.category == category &&
        other.restaurant == restaurant &&
        other.name == name &&
        other.price == price &&
        listEquals(other.ingredients, ingredients) &&
        other.createdAt == createdAt &&
        other.description == description &&
        other.discount == discount &&
        listEquals(other.testimonials, testimonials);
  }

  @override
  int get hashCode {
    return image.hashCode ^
        category.hashCode ^
        restaurant.hashCode ^
        name.hashCode ^
        price.hashCode ^
        ingredients.hashCode ^
        createdAt.hashCode ^
        description.hashCode ^
        discount.hashCode ^
        testimonials.hashCode;
  }
}
