import 'package:demo_bloc/pages/auth/bloc/auth_bloc.dart';
import 'package:demo_bloc/pages/auth/bloc/auth_state.dart';
import 'package:demo_bloc/pages/auth/reset_password_page.dart';
import 'package:demo_bloc/pages/counter/first_page.dart';
import 'package:demo_bloc/utils/auth_exception.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/auth_event.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _authBloc = AuthBloc();

  final _emailTec = TextEditingController(text: 'nam@gmail.com');
  final _passwordTec = TextEditingController();

  @override
  void dispose() {
    _authBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      bloc: _authBloc,
      listenWhen: (prev, curr) => curr is LoginSuccess,
      listener: (ctx, state) {
        if (state is LoginSuccess) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const FirstPage()),
          );
        }
      },
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextField(
                controller: _emailTec,
                decoration: const InputDecoration(labelText: 'Địa chỉ Email'),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _passwordTec,
                decoration: const InputDecoration(labelText: 'Mật khẩu'),
              ),
              BlocBuilder<AuthBloc, AuthState>(
                bloc: _authBloc,
                buildWhen: (prev, curr) =>
                    (curr is AuthError && curr.source == AuthSource.password) ||
                    prev is AuthError,
                builder: (ctx, state) {
                  if (state is AuthError) {
                    return Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        state.error,
                        style: const TextStyle(color: Colors.red),
                      ),
                    );
                  }
                  return Container();
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(fixedSize: const Size(120, 40)),
                child: BlocBuilder(
                  bloc: _authBloc,
                  buildWhen: (prev, curr) =>
                      curr is AuthLoading || prev is AuthLoading,
                  builder: (ctx, state) {
                    if (state is AuthLoading) {
                      return const SizedBox(
                          height: 30,
                          width: 30,
                          child:
                              CircularProgressIndicator(color: Colors.white));
                    }
                    return const Text('ĐĂNG NHẬP');
                  },
                ),
                onPressed: () {
                  _authBloc.add(Login(
                      email: _emailTec.text, password: _passwordTec.text));
                },
              ),
              const SizedBox(height: 20),
              TextButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (context) => const ResetPasswordPage()),
                  );
                },
                child: const Text('Quên mật khẩu?'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
