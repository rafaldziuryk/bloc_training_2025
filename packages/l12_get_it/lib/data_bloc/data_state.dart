import 'package:equatable/equatable.dart';
import 'package:data_service/domain/product.dart';

abstract class DataState extends Equatable {
  const DataState();

  @override
  List<Object> get props => [];
}

class DataInitial extends DataState {}

class DataLoading extends DataState {}

class DataSuccess extends DataState {
  final Map<Product, int> products;

  const DataSuccess(this.products);

  @override
  List<Object> get props => [products];
}

class DataFailure extends DataState {
  final String error;

  const DataFailure(this.error);

  @override
  List<Object> get props => [error];
} 