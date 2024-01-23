import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:food_ninja/src/data/models/testimonial.dart';
import 'package:food_ninja/src/data/repositories/testimonial_repository.dart';
part 'testimonial_event.dart';
part 'testimonial_state.dart';

class TestimonialBloc extends Bloc<TestimonialEvent, TestimonialState> {
  final TestimonialRepository _testimonialRepository = TestimonialRepository();
  TestimonialBloc() : super(TestimonialInitial()) {
    on<AddTestimonial>((event, emit) {
      try {
        emit(TestimonialLoading());
        _testimonialRepository.addTestimonial(
          event.rating,
          event.review,
          event.target,
        );
        emit(TestimonialSuccess());
      } catch (e, s) {
        debugPrint(e.toString());
        debugPrint(s.toString());
        emit(TestimonialFailure());
      }
    });
    on<FetchTestimonials>((event, emit) async {
      try {
        emit(TestimonialLoading());
        final List<Testimonial> testimonials =
            await _testimonialRepository.fetchTestimonials(event.target);

        emit(TestimonialsFetched(testimonials));
      } catch (e, s) {
        debugPrint(e.toString());
        debugPrint(s.toString());
        emit(TestimonialFailure());
      }
    });
  }
}
