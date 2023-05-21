import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

// ignore: must_be_immutable
class Restaurant extends Equatable {
  final String name;
  final String location;
  final DateTime createdAt;
  final String? image;
  final String? description;

  // id is the document id
  String? id;

  Restaurant({
    required this.name,
    required this.location,
    required this.createdAt,
    this.image,
    this.description,
  });

  factory Restaurant.fromMap(Map<String, dynamic> map) {
    return Restaurant(
      name: map['name'],
      image: map['image'],
      location: map['location'],
      description: map['description'],
      createdAt: map['createdAt'].toDate(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'image': image,
      'location': location,
      'description': description,
      'createdAt': createdAt,
    };
  }

  // restaurant is favorite
  bool get isFavorite {
    final box = Hive.box('myBox');
    final favorites = box.get('favoriteRestaurants') as List<dynamic>?;
    if (favorites == null || favorites.isEmpty) return false;
    DocumentReference ref = FirebaseFirestore.instance.doc('/restaurants/$id');
    return favorites.contains(ref);
  }

  @override
  List<Object?> get props => [
        name,
        image,
        location,
        description,
        createdAt,
      ];
}
