import 'package:data_service/domain/product.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:data_service/data/product_service_impl.dart';
import 'package:data_service/data/cart_service_impl.dart';
import 'package:data_service/domain/query_input.dart';
import 'package:l12_get_it/data_bloc/data_event.dart';
import 'package:l12_get_it/data_bloc/data_state.dart';
import 'package:rxdart/rxdart.dart';

class DataBloc extends Bloc<DataEvent, DataState> {
  final ProductServiceImpl _productService;
  final CartServiceImpl _cartService;

  DataBloc({
    required ProductServiceImpl productService,
    required CartServiceImpl cartService,
  }) : _productService = productService,
       _cartService = cartService,
       super(DataInitial()) {
    on<LoadDataEvent>(_onLoadData);
  }

  Future<void> _onLoadData(LoadDataEvent event, Emitter<DataState> emit) async {
    emit(DataLoading());

    await emit.forEach(
      Rx.combineLatest2(
        _productService.productStream,
        _cartService.cartStream,
            (productsList, cartMap) => Map.fromIterable(
          productsList,
          key: (element) => element as Product,
          value: (e) => cartMap[e] ?? 0,
        ),
      ),
      onData: (data) => DataSuccess(data),
    );
  }
} 