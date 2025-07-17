part of 'search_bloc.dart';

final class SearchState extends Equatable {
  final SortType sortType;
  final SortOrder sortOrder;
  final String query;
  final int min;
  final int max;

  const SearchState({
    required this.query,
    required this.min,
    required this.max,
    required this.sortType,
    required this.sortOrder,
  });

  SearchState copyWith({
    SortType? sortType,
    SortOrder? sortOrder,
    String? query,
    int? min,
    int? max,
  }) {
    return SearchState(
      query: query ?? this.query,
      min: min ?? this.min,
      max: max ?? this.max,
      sortType: sortType ?? this.sortType,
      sortOrder: sortOrder ?? this.sortOrder,
    );
  }

  @override
  List<Object?> get props => [sortType, sortOrder, query, min, max];
}
