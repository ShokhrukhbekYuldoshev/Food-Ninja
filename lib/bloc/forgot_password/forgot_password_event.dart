part of 'forgot_password_bloc.dart';

abstract class ForgotPasswordEvent extends Equatable {
  const ForgotPasswordEvent();

  @override
  List<Object> get props => [];
}

// send reset password link to the user's email
class SendResetPasswordLink extends ForgotPasswordEvent {
  final String email;

  const SendResetPasswordLink({required this.email});

  @override
  List<Object> get props => [email];
}
