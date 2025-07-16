part of 'data_bloc.dart';

sealed class DataEvent extends Equatable {
  const DataEvent();
}

class LoadDataEvent extends DataEvent {
  @override
  List<Object?> get props => [];
}

final class SearchEvent extends DataEvent {
  final String query;
  const SearchEvent(this.query);
  @override
  List<Object?> get props => [query];
}
