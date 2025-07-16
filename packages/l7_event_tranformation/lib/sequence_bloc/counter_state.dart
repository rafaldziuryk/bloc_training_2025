part of 'counter_bloc.dart';

abstract class CounterState extends Equatable {
  const CounterState();
}

class InitialCounterState extends CounterState {
  @override
  List<Object?> get props => [];
}

class CalculatingCounterState extends CounterState {
  @override
  List<Object?> get props => [];
}

class ValueCounterState extends CounterState {
  final int counter;

  const ValueCounterState(this.counter);

  @override
  List<Object?> get props => [counter];
}
