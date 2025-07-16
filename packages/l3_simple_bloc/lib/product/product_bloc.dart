import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductBloc() : super(ProductList(products: [])) {
    on<ProductAdd>(_onAddProduct);
    on<ProductDelete>(_onDeleteProduct);
  }

  List<String> products = [];

  FutureOr<void> _onAddProduct(ProductAdd event,Emitter<ProductState> emit) {
    products.add(event.product);
    emit(ProductList(products: List.unmodifiable(products)));
  }


  FutureOr<void> _onDeleteProduct(ProductDelete event,Emitter<ProductState> emit) {
    products.remove(event.product);
    emit(ProductList(products: List.unmodifiable(products)));
  }
}
