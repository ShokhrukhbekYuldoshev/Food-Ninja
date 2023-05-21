import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:food_ninja/models/testimonial.dart';
import 'package:hive/hive.dart';

// ignore: must_be_immutable
class Restaurant extends Equatable {
  final String name;
  final String location;
  final DateTime createdAt;
  final List<Testimonial> testimonials;
  final String? image;
  final String? description;

  // id is the document id
  String? id;

  Restaurant({
    required this.name,
    required this.location,
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
      'id': id,
      'name': name,
      'image': image,
      'location': location,
      'description': description,
      'createdAt': createdAt,
      'testimonials': testimonials.map((x) => x.toMap()).toList(),
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

  // rating is calculated by averaging all the ratings from testimonials
  double get rating {
    if (testimonials.isEmpty) return 0.0;
    return testimonials.map((e) => e.rating).reduce((a, b) => a + b) /
        testimonials.length;
  }

  @override
  List<Object?> get props => [
        name,
        image,
        location,
        description,
        createdAt,
        testimonials,
      ];
}
