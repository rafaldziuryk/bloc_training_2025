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
    on<LoadDataEvent>(onInit);

    // on<SearchEvent>(
    //   onSearch, 
    //   transformer: (events, mapper) => events.debounceTime(const Duration(milliseconds: 300)).
    //   switchMap(mapper));
  }

  FutureOr<void> onInit(event, emit) async {
    emit(DataLoading());
    await emit.forEach(dataService.filteredProductStream, onData: (data) => DataSuccess(data));
  }

  // FutureOr<void> onSearch(SearchEvent event, Emitter<DataState> emit) async {
  //   emit(DataLoading());
  //   try {
  //     print("query: $event");

  //     List<Product> products = await dataService.getProducts(NameDescriptionQueryInput(data: event.name));
      
  //     int fromParsed = int.tryParse(event.from) ?? 0;
  //     int toParsed = int.tryParse(event.to) ?? products.length;

  //     products = products.where((element) {
  //       return (element.idInt >= fromParsed) && (element.idInt <= toParsed);
  //     },).toList();

      
  //     emit(DataSuccess(products));
  //   } catch (e) {
  //     emit(DataFailure(e.toString()));
  //   }
  // }

  final ProductService dataService;
}
