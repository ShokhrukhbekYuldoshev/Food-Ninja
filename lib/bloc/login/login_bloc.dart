import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:bloc/bloc.dart';
import 'package:food_ninja/services/firebase_auth.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<LoginEvent>((event, emit) {});
    on<LoginSubmitted>((event, emit) async {
      emit(LoginLoading());

      try {
        FirebaseAuth firebaseAuth = FirebaseAuth.instance;

        await FirebaseAuthService(firebaseAuth).signInWithEmailAndPassword(
          email: event.email,
          password: event.password,
        );

        // TODO: save user data to Hive

        emit(LoginSuccess());
      } catch (e) {
        emit(LoginFailure(error: e.toString()));
      }
    });
  }
}
