part of 'counter_bloc.dart';

sealed class CounterState extends Equatable {
  const CounterState();
}

final class InitialCounterState extends CounterState {
  const InitialCounterState();
  @override
  List<Object?> get props => [];
}

final class CalculatingCounterState extends CounterState {
  const CalculatingCounterState();
  @override
  List<Object?> get props => [];
}

final class ValueCounterState extends CounterState {
  final int counter;
  const ValueCounterState(this.counter);
  @override
  List<Object?> get props => [counter];
}
