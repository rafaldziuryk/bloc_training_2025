part of 'search_bloc.dart';

final class SearchState extends Equatable {
  final SortType sortType;
  final SortOrder sortOrder;
  final String query;
  final int min;
  final int max;

  const SearchState(
    this.query,
    this.min,
    this.max, {
    required this.sortType,
    required this.sortOrder,
  });

  @override
  List<Object?> get props => [sortType, sortOrder, query, min, max];


}
