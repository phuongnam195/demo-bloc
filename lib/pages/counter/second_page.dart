import 'package:demo_bloc/pages/counter/cubit/counter_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SecondPage extends StatelessWidget {
  const SecondPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Counter (2)')),
      body: Center(
        child: BlocConsumer<CounterCubit, int>(
          listenWhen: (prev, curr) => curr > 20,
          listener: (ctx, state) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('It is more than 20'),
              ),
            );
          },
          builder: (ctx, state) => Text(
            '$state',
            style: const TextStyle(fontSize: 40),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          BlocProvider.of<CounterCubit>(context).increase();
        },
      ),
    );
  }
}
