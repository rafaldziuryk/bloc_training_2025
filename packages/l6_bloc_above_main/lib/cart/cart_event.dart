part of 'cart_bloc.dart';

sealed class CartEvent extends Equatable {
  const CartEvent();
}

class CartLoadEvent extends CartEvent {
  const CartLoadEvent();

  @override
  List<Object?> get props => [];
}

class AddToCartEvent extends CartEvent {
  final Product product;

  const AddToCartEvent(this.product);

  @override
  List<Object?> get props => [product];
}

class RemoveFromCartEvent extends CartEvent {
  final Product product;

  const RemoveFromCartEvent(this.product);

  @override
  List<Object?> get props => [product];
}
