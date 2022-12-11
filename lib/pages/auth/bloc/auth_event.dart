abstract class AuthEvent {}

class Login extends AuthEvent {
  final String email;
  final String password;

  Login({required this.email, required this.password});
}

class ResetPassword extends AuthEvent {
  final String email;

  ResetPassword({required this.email});
}
