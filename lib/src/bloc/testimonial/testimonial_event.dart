part of 'testimonial_bloc.dart';

abstract class TestimonialEvent extends Equatable {
  const TestimonialEvent();

  @override
  List<Object> get props => [];
}

class AddTestimonial extends TestimonialEvent {
  final double rating;
  final String review;
  final DocumentReference target;

  const AddTestimonial({
    required this.rating,
    required this.review,
    required this.target,
  });
}

class FetchTestimonials extends TestimonialEvent {
  final DocumentReference target;

  const FetchTestimonials({
    required this.target,
  });
}
