part of 'testimonial_bloc.dart';

abstract class TestimonialState extends Equatable {
  const TestimonialState();

  @override
  List<Object> get props => [];
}

class TestimonialInitial extends TestimonialState {}

class TestimonialLoading extends TestimonialState {}

class TestimonialSuccess extends TestimonialState {}

class TestimonialFailure extends TestimonialState {}

class TestimonialsFetched extends TestimonialState {
  final List<Testimonial> testimonials;

  const TestimonialsFetched(this.testimonials);
}
