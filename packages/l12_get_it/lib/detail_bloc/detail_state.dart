import 'package:equatable/equatable.dart';
import 'package:data_service/domain/product.dart';

abstract class DetailState extends Equatable {
  const DetailState();
}

class DetailInitial extends DetailState {
  @override
  List<Object> get props => [];
}

class DetailLoading extends DetailState {
  @override
  List<Object> get props => [];
}

class DetailSuccess extends DetailState {
  const DetailSuccess(this.product);

  final Product product;

  @override
  List<Object> get props => [product];
}

class DetailFailure extends DetailState {
  const DetailFailure(this.error);

  final String error;

  @override
  List<Object> get props => [error];
} 