import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class Testimonial extends Equatable {
  final String review;
  final double rating;
  final DocumentReference user;
  final DateTime createdAt;
  final DocumentReference target;

  const Testimonial(
    this.review,
    this.rating,
    this.user,
    this.createdAt,
    this.target,
  );

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'review': review,
      'rating': rating,
      'user': user,
      'createdAt': createdAt,
      'target': target,
    };
  }

  factory Testimonial.fromMap(Map<String, dynamic> map) {
    return Testimonial(
      map['review'] as String,
      map['rating'] * 1.0,
      map['user'] as DocumentReference,
      map['createdAt'].toDate(),
      map['target'] as DocumentReference,
    );
  }

  @override
  List<Object?> get props => [
        review,
        rating,
        user,
        createdAt,
        target,
      ];
}
