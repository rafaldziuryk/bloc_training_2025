import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'counter_event.dart';

part 'counter_state.dart';

class CounterBloc extends Bloc<CounterEvent, CounterState> {
  CounterBloc() : super(CounterData(counter: 0)) {
    on<IncrementCounterEvent>(incrementEvent);
    on<DecrementCounterEvent>(decrementEvent);
  }

  int counter = 0;

  FutureOr<void> incrementEvent(event, emit) async {
    emit(CounterCalculating());
    await Future.delayed(Duration(seconds: 2));
    counter++;
    emit(CounterData(counter: counter));
  }

  FutureOr<void> decrementEvent(event, emit) async {
    emit(CounterCalculating());
    await Future.delayed(Duration(seconds: 2));
    counter--;
    emit(CounterData(counter: counter));
  }
}