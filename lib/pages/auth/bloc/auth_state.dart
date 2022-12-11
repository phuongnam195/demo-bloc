import 'package:demo_bloc/model/user.dart';
import 'package:demo_bloc/utils/auth_exception.dart';

abstract class AuthState {}

class AuthInit extends AuthState {}

class AuthLoading extends AuthState {}

class LoginSuccess extends AuthState {
  final User user;

  LoginSuccess(this.user);
}

class ResetPasswordSuccess extends AuthState {}

class AuthError extends AuthState {
  final String error;
  final AuthSource source;

  AuthError(this.error, this.source);
}
