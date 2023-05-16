import 'package:equatable/equatable.dart';

class Testimonial extends Equatable {
  final String userEmail;
  final String? userImage;
  final String comment;
  final int rating;
  final DateTime createdAt;

  const Testimonial({
    required this.userEmail,
    this.userImage,
    required this.comment,
    required this.rating,
    required this.createdAt,
  });

  factory Testimonial.fromMap(Map<String, dynamic> map) {
    return Testimonial(
      userEmail: map['userEmail'],
      userImage: map['userImage'],
      comment: map['comment'],
      rating: map['rating'],
      createdAt: map['createdAt'].toDate(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userEmail': userEmail,
      'userImage': userImage,
      'comment': comment,
      'rating': rating,
      'createdAt': createdAt,
    };
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Testimonial &&
        other.userEmail == userEmail &&
        other.userImage == userImage &&
        other.comment == comment &&
        other.rating == rating &&
        other.createdAt == createdAt;
  }

  @override
  int get hashCode {
    return userEmail.hashCode ^
        userImage.hashCode ^
        comment.hashCode ^
        rating.hashCode ^
        createdAt.hashCode;
  }

  @override
  List<Object?> get props {
    return [
      userEmail,
      userImage,
      comment,
      rating,
      createdAt,
    ];
  }
}
