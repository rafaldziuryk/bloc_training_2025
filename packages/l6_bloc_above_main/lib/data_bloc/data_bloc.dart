import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:data_service/domain/product_service.dart';
import 'package:data_service/domain/product.dart';
import 'package:data_service/domain/query_input.dart';
import 'package:equatable/equatable.dart';

part 'data_event.dart';

part 'data_state.dart';

class DataBloc extends Bloc<DataEvent, DataState> {
  DataBloc({required this.dataService}) : super(DataInitial()) {
    on<LoadDataEvent>(onInit);
    on<RemoveProductEvent>(onRemoveProduct);
  }

  final ProductService dataService;

  FutureOr<void> onInit(LoadDataEvent event, Emitter<DataState> emit) async {
    await emit.forEach(dataService.productStream, onData: (data) => DataSuccess(data));
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
