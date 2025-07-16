part of 'data_bloc.dart';

sealed class DataState extends Equatable {
  const DataState();
}

final class DataInitial extends DataState {
  @override
  List<Object> get props => [];
}

final class DataLoading extends DataState {
  @override
  List<Object> get props => [];
}

final class DataSuccess extends DataState {
  const DataSuccess(this.products);

  final Map<Product, int> products;

  @override
  List<Object> get props => [products];
}

final class DataFailure extends DataState {
  const DataFailure(this.error);

  final String error;

  @override
  List<Object> get props => [error];
}
