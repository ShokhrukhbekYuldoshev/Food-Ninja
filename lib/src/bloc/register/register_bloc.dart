import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

import 'package:food_ninja/src/data/services/firebase_auth.dart';
import 'package:hive/hive.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc() : super(RegisterInitial()) {
    on<RegisterEvent>((event, emit) {});
    on<RegisterSubmitted>((event, emit) async {
      emit(RegisterLoading());

      try {
        FirebaseAuth firebaseAuth = FirebaseAuth.instance;

        await FirebaseAuthService(firebaseAuth).createUserWithEmailAndPassword(
          email: event.email,
          password: event.password,
        );

        var box = Hive.box('myBox');
        box.put('email', event.email);

        emit(RegisterSuccess());
      } catch (e, s) {
        debugPrint(e.toString());
        debugPrint(s.toString());
        emit(RegisterError(error: e.toString()));
      }
    });
  }
}
