part of 'counter_bloc.dart';

sealed class CounterState extends Equatable {
  const CounterState();
}

final class CounterData extends CounterState {
  const CounterData({required this.counter});

  final int counter;

  @override
  List<Object> get props => [counter];
}

final class CounterCalculating extends CounterState {
  @override
  List<Object?> get props => [];
}
