part of 'data_bloc.dart';

sealed class DataEvent extends Equatable {
  const DataEvent();
}

class LoadDataEvent extends DataEvent {
  @override
  List<Object?> get props => [];
}

// final class SearchEvent extends DataEvent {
//   final String name;
//   final String from;
//   final String to;
//   const SearchEvent(this.name, this.from, this.to);
//   @override
//   List<Object?> get props => [name, from, to];
// }

final class RemoveDataEvent extends DataEvent {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}
