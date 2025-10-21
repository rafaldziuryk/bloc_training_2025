import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'counter_plus_event.dart';
part 'counter_plus_state.dart';

class CounterPlusBloc extends Bloc<CounterPlusEvent, CounterPlusState> {
  CounterPlusBloc() : super(CounterPlusInitial()) {
    on<CounterPlusEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
