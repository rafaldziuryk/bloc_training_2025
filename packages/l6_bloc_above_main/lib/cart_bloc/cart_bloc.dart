import 'package:bloc/bloc.dart';
import 'package:data_service/domain/cart_service.dart';
import 'package:data_service/domain/product.dart';
import 'package:equatable/equatable.dart';

part 'cart_event.dart';

part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc(this.cartService) : super(CartData({})) {
    on<CartLoadEvent>((event, emit) async {
      await emit.forEach(cartService.cartStream, onData: (data) => CartData(data));
    });
    on<AddToCartEvent>((event, emit) {
      cartService.addItem(event.product);
    });
    on<RemoveFromCartEvent>((event, emit) {
      cartService.removeItem(event.product);
    });
  }

  final CartService cartService;
}
