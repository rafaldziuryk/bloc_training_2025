part of 'search_bloc.dart';

@immutable
sealed class SearchEvent extends Equatable {}

final class QueryEvent extends SearchEvent {
  final String query;

  QueryEvent({required this.query});

  @override
  List<Object?> get props => [query];
}

final class FromEvent extends SearchEvent {
  final String from;

  FromEvent({required this.from});

  @override
  List<Object?> get props => [from];
}

final class ToEvent extends SearchEvent {
  final String to;

  ToEvent({required this.to});
  
  @override
  List<Object?> get props => [to];
}

final class SortTypeEvent extends SearchEvent {

  final SortType sortType;

  SortTypeEvent({required this.sortType});

  @override
  List<Object?> get props => [sortType];
}

final class SortOrderEvent extends SearchEvent {

  final SortOrder sortOrder;

  SortOrderEvent({required this.sortOrder});

  @override
  List<Object?> get props => [sortOrder];
}
