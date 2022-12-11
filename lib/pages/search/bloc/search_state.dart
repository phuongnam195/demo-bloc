abstract class SearchState {}

class SearchInit extends SearchState {}

class SearchLoading extends SearchState {}

class SearchSuccess extends SearchState {
  final List<String> result;

  SearchSuccess(this.result);
}

class SearchError extends SearchState {
  final String error;

  SearchError(this.error);
}
