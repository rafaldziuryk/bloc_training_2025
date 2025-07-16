import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'counter_event.dart';
part 'counter_state.dart';

class CounterBloc extends Bloc<CounterEvent, CounterData> {
  CounterBloc() : super(CounterData(0)) {
    on<IncrementCounterEvent>(incrementEvent);
    on<DecrementCounterEvent>(decrementEvent);
  }

  int counter = 0;

  FutureOr<void> incrementEvent(event, emit) async {
    counter++;
    emit(CounterData(counter));
  }

  FutureOr<void> decrementEvent(event, emit) {
    counter--;
    emit(CounterData(counter));
  }
}
