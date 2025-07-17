import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:data_service/domain/product_service.dart';
import 'package:data_service/domain/product.dart';
import 'package:data_service/domain/query_input.dart';
import 'package:equatable/equatable.dart';
import 'package:rxdart/rxdart.dart';

part 'data_event.dart';

part 'data_state.dart';

class DataBloc extends Bloc<DataEvent, DataState> {
  DataBloc({required this.dataService}) : super(DataInitial()) {
    on<LoadDataEvent>(onRefresh);
  }

  FutureOr<void> onRefresh(event, emit) async {
    emit(DataLoading());
    try {
      final products = await dataService.getProducts();
      emit(DataSuccess(products));
    } catch (error) {
      emit(DataFailure(error.toString()));
    }
  }

  final ProductService dataService;
}
