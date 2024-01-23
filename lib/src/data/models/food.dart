import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

import 'package:hive/hive.dart';

// ignore: must_be_immutable
class Food extends Equatable {
  final DocumentReference category;
  final DocumentReference restaurant;
  final String name;
  final double price;
  final List<String> ingredients;
  final DateTime createdAt;
  final String? image;
  final String? description;
  final double? discount;

  // for cart
  int quantity = 0;

  // id is the document id
  String? id;

  Food({
    required this.category,
    required this.restaurant,
    required this.name,
    required this.price,
    required this.ingredients,
    required this.createdAt,
    this.image,
    this.discount,
    this.description,
    required this.quantity,
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
      quantity: map['quantity'] ?? 0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'image': image,
      'category': category,
      'restaurant': restaurant,
      'name': name,
      'price': price,
      'ingredients': ingredients,
      'createdAt': createdAt,
      'discount': discount ?? 0.0,
      'description': description ?? '',
    };
  }

  // food is favorite
  bool get isFavorite {
    final box = Hive.box('myBox');
    final favorites = box.get('favoriteFoods') as List<dynamic>?;
    if (favorites == null || favorites.isEmpty) return false;
    DocumentReference ref = FirebaseFirestore.instance.doc('/foods/$id');
    return favorites.contains(ref);
  }

  @override
  List<Object> get props => [name, createdAt];
}
