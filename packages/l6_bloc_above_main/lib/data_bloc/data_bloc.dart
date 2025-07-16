import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:data_service/domain/cart_service.dart';
import 'package:data_service/domain/product_service.dart';
import 'package:data_service/domain/product.dart';
import 'package:equatable/equatable.dart';

part 'data_event.dart';

part 'data_state.dart';

class DataBloc extends Bloc<DataEvent, DataState> {
  DataBloc({required this.dataService, required this.cartService}) : super(DataInitial()) {
    on<LoadDataEvent>(onInit);
    on<RemoveProductEvent>(onRemoveProduct);
    on<_CalculateEvent>(onCalculateProduct);
  }

  final ProductService dataService;
  final CartService cartService;
  late final StreamSubscription cartStream;
  late final StreamSubscription productStream; //close
  List<Product> productList = [];
  Map<Product, int> cartMap = {};


  FutureOr<void> onInit(LoadDataEvent event, Emitter<DataState> emit) async {
    // przerobic zeby on sam z siebie emitowal dane bezposrednio z iloscia w koszyku
    //
    
    productStream = dataService.productStream.listen((data) {
      productList = data;
      add(_CalculateEvent());
    });

    cartStream = cartService.cartStream.listen((data) {
      cartMap = data;
      add(_CalculateEvent());
    });
  }

  FutureOr<void> onCalculateProduct(event, emit) async {
    // final quantity = cartState is CartData ? cartState.cart[item] ?? 0 : 0; //

    final maptemp = Map.fromIterable(
      productList,
      key:(element) => element as Product,
      value: (e) => cartMap[e] ?? 0,
    );

    emit(DataSuccess(maptemp));
  }

  FutureOr<void> onRemoveProduct(event, emit) async {
    emit(DataLoading());
    try {
      dataService.remove(event.product);
    } catch (e) {
      emit(DataFailure(e.toString()));
    }
  }

  @override
  Future<void> close() {
    cartStream.cancel();
    productStream.cancel();
    return super.close();
  }
}
