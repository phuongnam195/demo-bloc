// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:bloc_test/bloc_test.dart';
import 'package:demo_bloc/pages/counter/cubit/counter_cubit.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('CounterBloc', () {
    late CounterCubit counterCubit;

    setUp(() {
      counterCubit = CounterCubit();
    });

    test('initial state is 0', () {
      expect(counterCubit.state, 0);
    });

    blocTest(
      'emits [1] when increase() was called',
      build: () => counterCubit,
      act: (cubit) => cubit.increase(),
      expect: () => [1],
    );

    blocTest(
      'emits [-1] when decrease() was called',
      build: () => counterCubit,
      act: (cubit) => cubit.decrease(),
      expect: () => [-1],
    );
  });
}
