import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:l11_bloc_watch/counter_bloc/counter_event.dart';
import 'package:l11_bloc_watch/counter_bloc/counter_state.dart';

class CounterBloc extends Bloc<CounterEvent, CounterState> {
  CounterBloc() : super(const CounterState()) {
    on<CounterIncremented>(_onIncremented);
    on<CounterDecremented>(_onDecremented);
    on<CounterReset>(_onReset);
  }

  void _onIncremented(CounterIncremented event, Emitter<CounterState> emit) {
    emit(state.copyWith(count: state.count + 1));
  }

  void _onDecremented(CounterDecremented event, Emitter<CounterState> emit) {
    emit(state.copyWith(count: state.count - 1));
  }

  void _onReset(CounterReset event, Emitter<CounterState> emit) {
    emit(state.copyWith(count: 0));
  }
} 