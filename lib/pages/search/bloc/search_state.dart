import 'package:equatable/equatable.dart';

abstract class SearchState extends Equatable {}

class SearchInit extends SearchState {
  @override
  List<Object?> get props => [];
}

class SearchLoading extends SearchState {
  @override
  List<Object?> get props => [];
}

class SearchSuccess extends SearchState {
  final List<String> result;

  SearchSuccess(this.result);

  @override
  List<Object?> get props => [result];
}

class SearchError extends SearchState {
  final String error;

  SearchError(this.error);

  @override
  List<Object?> get props => [error];
}
