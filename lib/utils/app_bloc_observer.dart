import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';

class AppBlocObserver extends BlocObserver {
  @override
  void onChange(BlocBase<dynamic> bloc, Change<dynamic> change) {
    super.onChange(bloc, change);
    log('Bloc -> onChange(${bloc.runtimeType}, $change)');
  }

  @override
  void onError(BlocBase<dynamic> bloc, Object error, StackTrace stackTrace) {
    super.onError(bloc, error, stackTrace);
    log('Bloc -> onError(${bloc.runtimeType}, $error, $stackTrace)');
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    log('Bloc -> onTransition(${bloc.runtimeType}, $transition)');
  }

  @override
  void onCreate(BlocBase bloc) {
    log('Bloc -> onCreate(${bloc.runtimeType})');
    super.onCreate(bloc);
  }

  @override
  void onClose(BlocBase bloc) {
    log('Bloc -> onClose(${bloc.runtimeType})');
    super.onClose(bloc);
  }
}
