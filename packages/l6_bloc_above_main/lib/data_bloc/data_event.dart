part of 'data_bloc.dart';

sealed class DataEvent extends Equatable {
  const DataEvent();
}

class LoadDataEvent extends DataEvent {
  @override
  List<Object?> get props => [];
}

class RemoveProductEvent extends DataEvent {
  final Product product;

  const RemoveProductEvent(this.product);

  @override
  List<Object?> get props => [];
}
