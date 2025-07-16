part of 'search_bloc.dart';


final class SearchState extends Equatable {

  final SortType sortType;
  final SortOrder sortOrder;

  const SearchState({
    required this.sortType,
    required this.sortOrder,
  });
  
  @override
  List<Object?> get props => [sortType, sortOrder];
}

