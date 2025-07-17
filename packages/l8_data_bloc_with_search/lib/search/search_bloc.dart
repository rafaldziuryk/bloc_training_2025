import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:data_service/domain/product_service.dart';
import 'package:data_service/domain/query_input.dart';
import 'package:equatable/equatable.dart';
import 'package:data_service/domain/search_enum.dart';
import 'package:meta/meta.dart';

part 'search_event.dart';

part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final ProductService dataService;

  SearchBloc({required this.dataService})
      : super(SearchState(sortType: SortType.alphabet, sortOrder: SortOrder.asc)) {
    on<SearchEvent>(_onSearch);
  }

  FutureOr<void> _onSearch(SearchEvent event, Emitter<SearchState> emit) {
    switch (event) {
      case QueryEvent():
        dataService.filterList.removeWhere((element) => element is NameDescriptionQueryInput,);
        dataService.filterList.add(NameDescriptionQueryInput(data: event.query));
      case FromEvent():
        int fromParsed = int.tryParse(event.from) ?? 0;
        dataService.filterList.removeWhere((element) => element is MinIdQueryInput,);
        dataService.filterList.add(MinIdQueryInput(data: fromParsed));
      case ToEvent():
        int toParsed = int.tryParse(event.to) ?? 1000;
        dataService.filterList.removeWhere((element) => element is MaxIdQueryInput,);
        dataService.filterList.add(MaxIdQueryInput(data: toParsed));
      case SortTypeEvent():
        throw UnimplementedError();
      case SortOrderEvent():
        throw UnimplementedError();
    }

    SearchState(sortType: SortType.alphabet, sortOrder: SortOrder.asc)

    // dataService.setFilter(dataService.filterList);
  }
}
