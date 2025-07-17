import 'package:equatable/equatable.dart';
import 'package:data_service/domain/product.dart';

abstract class CartState extends Equatable {
  const CartState();

  @override
  List<Object> get props => [];
}

class CartInitial extends CartState {}

class CartLoading extends CartState {}

class CartData extends CartState {
  final Map<Product, int> cart;

  const CartData(this.cart);

  @override
  List<Object> get props => [cart];
}

class CartError extends CartState {
  final String error;

  const CartError(this.error);

  @override
  List<Object> get props => [error];
} 