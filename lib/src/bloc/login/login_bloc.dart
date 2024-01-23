import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:bloc/bloc.dart';
import 'package:food_ninja/src/data/services/firebase_auth.dart';
import 'package:food_ninja/src/data/services/firestore_db.dart';
import 'package:food_ninja/src/data/models/user.dart' as model;
import 'package:hive_flutter/hive_flutter.dart';
part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<LoginEvent>((event, emit) {});
    on<LoginSubmitted>((event, emit) async {
      emit(LoginLoading());

      try {
        FirebaseAuth firebaseAuth = FirebaseAuth.instance;

        // sign in with email and password
        await FirebaseAuthService(firebaseAuth).signInWithEmailAndPassword(
          email: event.email,
          password: event.password,
        );

        var userDocument = (await FirestoreDatabase().getDocumentsWithQuery(
          "users",
          "email",
          event.email,
        ))
            .docs[0];

        // save user data to Hive
        model.User user = model.User.fromMap(
          userDocument.data() as Map<String, dynamic>,
        );
        user.id = userDocument.id;

        user.saveToHive();
        var box = Hive.box("myBox");
        box.put("isRegistered", true);

        // emit success
        emit(LoginSuccess());
      } on FirebaseAuthException catch (e) {
        emit(
          LoginError(
            error: FirebaseAuthService(FirebaseAuth.instance).getErrorString(
              e.code,
            ),
          ),
        );
      } catch (e, s) {
        debugPrint(e.toString());
        debugPrint(s.toString());
        emit(LoginError(error: e.toString()));
      }
    });
  }
}
