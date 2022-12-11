import 'dart:developer';

import 'package:demo_bloc/pages/auth/bloc/auth_event.dart';
import 'package:demo_bloc/pages/auth/bloc/auth_state.dart';
import 'package:demo_bloc/repository/repository.dart';
import 'package:demo_bloc/utils/auth_exception.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInit()) {
    on<Login>(_onLogin);
    on<ResetPassword>(_onResetPassword);
  }

  _onLogin(Login event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final user = await Repository.login(event.email, event.password);
      emit(LoginSuccess(user));
    } on AuthException catch (e) {
      emit(AuthError('$e', e.source));
    } catch (e) {
      emit(AuthError('$e', AuthSource.unknown));
    }
  }

  _onResetPassword(ResetPassword event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      await Repository.resetPassword(event.email);
      emit(ResetPasswordSuccess());
    } on AuthException catch (e) {
      emit(AuthError('$e', e.source));
    } catch (e) {
      emit(AuthError('$e', AuthSource.unknown));
    }
  }

  // TODO: Test observer cho 1 Bloc
  // @override
  // void onTransition(Transition<AuthEvent, AuthState> transition) {
  //   super.onTransition(transition);
  //   log('AuthBloc -> onTransition($transition)');
  // }
}
