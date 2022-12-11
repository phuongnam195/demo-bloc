import 'package:demo_bloc/repository/repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';

import 'search_event.dart';
import 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc() : super(SearchInit()) {
    EventTransformer<T> debounce<T>(Duration duration) {
      return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
    }

//----------------------

    on<SearchMember>(
      _onSearchMember,
      transformer: debounce(const Duration(milliseconds: 500)),
    );
  }

  _onSearchMember(SearchMember event, Emitter<SearchState> emit) async {
    emit(SearchLoading());
    try {
      final result = await Repository.searchMobileMember(event.keyword);

      emit(SearchSuccess(result));

      // // TODO: Test emit 2 state giống nhau
      // final state = SearchSuccess(result);
      // emit(state);
      // await Future.delayed(const Duration(seconds: 1));
      // emit(state);

      // // TODO: Test emit 2 state cùng dữ liệu
      // emit(SearchSuccess(result));
      // await Future.delayed(const Duration(seconds: 1));
      // emit(SearchSuccess(result));
    } catch (e) {
      emit(SearchError('$e'));
    }
  }
}

EventTransformer<T> debounce<T>(Duration duration) {
  return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
}
