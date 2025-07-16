part of 'detail_bloc.dart';

sealed class DetailState extends Equatable {
  const DetailState();
}

final class DetailInitial extends DetailState {
  @override
  List<Object> get props => [];
}

final class DetailLoading extends DetailState {
  @override
  List<Object> get props => [];
}

final class DetailSuccess extends DetailState {
  const DetailSuccess(this.product);

  final Product product;

  @override
  List<Object> get props => [product];
}

final class DetailFailure extends DetailState {
  const DetailFailure(this.error);

  final String error;

  @override
  List<Object> get props => [error];
} 