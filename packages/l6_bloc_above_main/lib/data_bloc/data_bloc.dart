import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:data_service/domain/cart_service.dart';
import 'package:data_service/domain/product_service.dart';
import 'package:data_service/domain/product.dart';
import 'package:equatable/equatable.dart';
import 'package:rxdart/rxdart.dart';

part 'data_event.dart';

part 'data_state.dart';

class DataBloc extends Bloc<DataEvent, DataState> {
  DataBloc({required this.dataService, required this.cartService}) : super(DataInitial()) {
    on<LoadDataEvent>(onInit);
    on<RemoveProductEvent>(onRemoveProduct);
  }

  final ProductService dataService;
  final CartService cartService;

  FutureOr<void> onInit(LoadDataEvent event, Emitter<DataState> emit) async {
    await emit.forEach(
      Rx.combineLatest2(
        dataService.productStream,
        cartService.cartStream,
        (productsList, cartMap) => Map.fromIterable(
          productsList,
          key: (element) => element as Product,
          value: (e) => cartMap[e] ?? 0,
        ),
      ),
      onData: (data) => DataSuccess(data),
    );
  }

  FutureOr<void> onRemoveProduct(event, emit) async {
    emit(DataLoading());
    try {
      dataService.remove(event.product);
    } catch (e) {
      emit(DataFailure(e.toString()));
    }
  }
}
