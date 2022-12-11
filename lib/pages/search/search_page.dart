import 'package:demo_bloc/pages/search/bloc/search_bloc.dart';
import 'package:demo_bloc/pages/search/bloc/search_event.dart';
import 'package:demo_bloc/pages/search/bloc/search_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    final searchBloc = SearchBloc();

    return Scaffold(
      appBar: AppBar(title: const Text('Search')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              decoration: const InputDecoration(
                hintText: 'Tìm kiếm thành viên Team Mobile',
              ),
              onChanged: (keyword) => searchBloc.add(SearchMember(keyword)),
            ),
            const SizedBox(height: 20),
            BlocBuilder(
              bloc: searchBloc,
              buildWhen: (prev, curr) =>
                  curr is SearchLoading || curr is SearchSuccess,
              builder: (ctx, state) {
                if (state is SearchLoading) {
                  return const SizedBox(
                    width: 60,
                    height: 60,
                    child: CircularProgressIndicator(),
                  );
                } else if (state is SearchSuccess) {
                  List<String> result = state.result;
                  print('REBUILD LIST RESULT (length = ${result.length})');
                  return Expanded(
                    child: ListView.builder(
                      itemCount: result.length,
                      itemBuilder: (_, i) => ListTile(title: Text(result[i])),
                    ),
                  );
                }
                return Container();
              },
            ),
          ],
        ),
      ),
    );
  }
}
