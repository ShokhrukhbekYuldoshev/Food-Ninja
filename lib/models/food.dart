import 'package:cloud_firestore/cloud_firestore.dart';

class Food {
  final String image;
  final DocumentReference category;
  final DocumentReference restaurant;
  final String name;
  final double price;
  final double rating;
  final double discount;
  final String description;
  final List<String> ingredients;
  final DateTime createdAt;

  Food({
    required this.image,
    required this.category,
    required this.restaurant,
    required this.name,
    required this.price,
    required this.rating,
    required this.discount,
    required this.description,
    required this.ingredients,
    required this.createdAt,
  });

  factory Food.fromMap(Map<String, dynamic> map) {
    return Food(
      image: map['image'],
      category: map['category'],
      restaurant: map['restaurant'],
      name: map['name'],
      price: map['price'],
      rating: map['rating'],
      discount: map['discount'],
      description: map['description'],
      ingredients: map['ingredients'],
      createdAt: map['createdAt'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'image': image,
      'category': category,
      'restaurant': restaurant,
      'name': name,
      'price': price,
      'rating': rating,
      'discount': discount,
      'description': description,
      'ingredients': ingredients,
      'createdAt': createdAt,
    };
  }
}
