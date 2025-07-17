import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:l10_bloc_selector/counter_bloc/counter_event.dart';
import 'package:l10_bloc_selector/counter_bloc/counter_state.dart';

class CounterBloc extends Bloc<CounterEvent, CounterState> {
  CounterBloc() : super(const CounterState()) {
    on<CounterStarted>(_onStarted);
    on<CounterIncremented>(_onIncremented);
    on<CounterDecremented>(_onDecremented);
    on<CounterReset>(_onReset);
  }

  Future<void> _onStarted(CounterStarted event, Emitter<CounterState> emit) async {
    emit(state.copyWith(
      status: CounterStatus.loading,
      lastUpdated: DateTime.now().toString(),
    ));
    
    // Simulate some loading
    await Future.delayed(const Duration(milliseconds: 500));
    
    emit(state.copyWith(
      status: CounterStatus.success,
      lastUpdated: DateTime.now().toString(),
    ));
  }

  void _onIncremented(CounterIncremented event, Emitter<CounterState> emit) {
    emit(state.copyWith(
      count: state.count + 1,
      lastUpdated: DateTime.now().toString(),
    ));
  }

  void _onDecremented(CounterDecremented event, Emitter<CounterState> emit) {
    emit(state.copyWith(
      count: state.count - 1,
      lastUpdated: DateTime.now().toString(),
    ));
  }

  void _onReset(CounterReset event, Emitter<CounterState> emit) {
    emit(state.copyWith(
      count: 0,
      lastUpdated: DateTime.now().toString(),
    ));
  }
} 