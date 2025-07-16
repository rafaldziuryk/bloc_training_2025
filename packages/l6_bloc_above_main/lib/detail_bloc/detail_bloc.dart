import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:data_service/domain/product.dart';
import 'package:data_service/data/product_service_impl.dart';
import 'package:equatable/equatable.dart';

part 'detail_event.dart';
part 'detail_state.dart';

class DetailBloc extends Bloc<DetailEvent, DetailState> {
  DetailBloc({required this.productId}) : super(DetailInitial()) {
    on<LoadDetailEvent>(_onLoadDetail);
  }

  final String productId;

  FutureOr<void> _onLoadDetail(LoadDetailEvent event, Emitter<DetailState> emit) async {
    emit(DetailLoading());
    try {
      final products = await ProductServiceImpl().productStream.first;
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