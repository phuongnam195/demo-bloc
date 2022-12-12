import 'package:demo_bloc/pages/counter/cubit/counter_cubit.dart';
import 'package:demo_bloc/pages/counter/second_page.dart';
import 'package:demo_bloc/pages/search/search_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FirstPage extends StatelessWidget {
  const FirstPage({super.key});

  @override
  Widget build(BuildContext context) {
    final counterCubit = CounterCubit();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Counter (1)'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const SearchPage()),
              );
            },
          )
        ],
      ),
      body: _Body(counterCubit),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => counterCubit.increase(),
        // TODO: Test lấy Bloc ở cùng một context
        // onPressed: () => BlocProvider.of<CounterCubit>(context).increase(),
      ),
    );
  }
}

class _Body extends StatelessWidget {
  final CounterCubit counterCubit;

  const _Body(this.counterCubit, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: BlocListener<CounterCubit, int>(
        bloc: counterCubit,
        listenWhen: (prev, curr) => curr == 10,
        // listenWhen: (prev, curr) => curr >= 10, // TODO: Test listen ở màn hình cũ
        listener: (ctx, state) {
          Navigator.of(ctx).push(
            MaterialPageRoute(
              builder: (_) => SecondPage(counterCubit),
            ),
          );

          // TODO: Test không dùng BlocProvider.value() để truyền Bloc sang màn hình mới
          // Navigator.of(ctx).push(
          //   MaterialPageRoute(
          //     builder: (_) => const SecondPage(),
          //   ),
          // );
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            BlocBuilder<CounterCubit, int>(
              bloc: counterCubit,
              builder: (ctx, state) => Text(
                '$state',
                style: const TextStyle(fontSize: 40),
              ),
            ),
            const SizedBox(height: 15),
            BlocSelector<CounterCubit, int, bool>(
              bloc: counterCubit,
              selector: (count) => count % 5 == 0,
              builder: (ctx, state) => Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: state == true ? Colors.red : Colors.green),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
