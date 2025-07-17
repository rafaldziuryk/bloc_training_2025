import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:data_service/data/cart_service_impl.dart';
import 'package:l12_get_it/cart_bloc/cart_event.dart';
import 'package:l12_get_it/cart_bloc/cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final CartServiceImpl _cartService;

  CartBloc({
    required CartServiceImpl cartService,
  }) : _cartService = cartService,
       super(CartInitial()) {
    on<CartLoadEvent>(_onLoadCart);
    on<AddToCartEvent>(_onAddToCart);
    on<RemoveFromCartEvent>(_onRemoveFromCart);
  }

  Future<void> _onLoadCart(CartLoadEvent event, Emitter<CartState> emit) async {
    emit(CartLoading());
    await emit.forEach(_cartService.cartStream, onData: (data) => CartData(data),);
  }

  void _onAddToCart(AddToCartEvent event, Emitter<CartState> emit) {
    _cartService.addItem(event.product);
  }

  void _onRemoveFromCart(RemoveFromCartEvent event, Emitter<CartState> emit) {
    _cartService.removeItem(event.product);
  }
} 