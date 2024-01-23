import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:food_ninja/src/data/services/firebase_auth.dart';

part 'forgot_password_event.dart';
part 'forgot_password_state.dart';

class ForgotPasswordBloc
    extends Bloc<ForgotPasswordEvent, ForgotPasswordState> {
  ForgotPasswordBloc() : super(ForgotPasswordInitial()) {
    on<SendResetPasswordLink>((event, emit) async {
      try {
        emit(ForgotPasswordLoading());
        await FirebaseAuthService(FirebaseAuth.instance).sendPasswordResetEmail(
          event.email,
        );

        emit(
          const ForgotPasswordSuccess(
            message:
                'A password reset link has been sent to your email address.',
          ),
        );
      } catch (e) {
        emit(ForgotPasswordFailure(error: e.toString()));
      }
    });
  }
}
