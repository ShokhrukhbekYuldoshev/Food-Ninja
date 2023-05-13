class Testimonial {
  final String userEmail;
  final String? userImage;
  final String comment;
  final int rating;
  final DateTime createdAt;

  Testimonial({
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
}
