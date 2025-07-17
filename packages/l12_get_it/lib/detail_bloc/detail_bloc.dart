import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:data_service/domain/product.dart';
import 'package:data_service/data/product_service_impl.dart';
import 'package:l12_get_it/detail_bloc/detail_event.dart';
import 'package:l12_get_it/detail_bloc/detail_state.dart';

class DetailBloc extends Bloc<DetailEvent, DetailState> {
  DetailBloc({
    required this.productId,
    required this.productService,
  }) : super(DetailInitial()) {
    on<LoadDetailEvent>(_onLoadDetail);
  }

  final String productId;
  final ProductServiceImpl productService;

  FutureOr<void> _onLoadDetail(LoadDetailEvent event, Emitter<DetailState> emit) async {
    emit(DetailLoading());
    try {
      final products = await productService.productStream.first;
      final product = products.firstWhere(
        (p) => p.id == productId,
        orElse: () => Product(id: '', name: '', description: ''),
      );
      if (product.id.isEmpty) {
        emit(const DetailFailure('Produkt nie został znaleziony'));
      } else {
        emit(DetailSuccess(product));
      }
    } catch (e) {
      emit(DetailFailure(e.toString()));
    }
  }
} 