abstract class SearchEvent {}

class SearchMember extends SearchEvent {
  final String keyword;

  SearchMember(this.keyword);
}
