import 'package:equatable/equatable.dart';
import 'package:data_service/domain/product.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object> get props => [];
}

class CartLoadEvent extends CartEvent {}

class AddToCartEvent extends CartEvent {
  final Product product;

  const AddToCartEvent(this.product);

  @override
  List<Object> get props => [product];
}

class RemoveFromCartEvent extends CartEvent {
  final Product product;

  const RemoveFromCartEvent(this.product);

  @override
  List<Object> get props => [product];
} 