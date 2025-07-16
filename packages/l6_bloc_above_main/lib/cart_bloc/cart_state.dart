part of 'cart_bloc.dart';

sealed class CartState extends Equatable {
  const CartState();
}

final class CartData extends CartState {
  final Map<Product, int> cart;

  const CartData(this.cart);

  @override
  List<Object?> get props => [cart];
}
