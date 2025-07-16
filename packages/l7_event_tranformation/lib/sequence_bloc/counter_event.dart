part of 'counter_bloc.dart';

sealed class CounterEvent extends Equatable {
  const CounterEvent();
}

final class CounterIncrement extends CounterEvent {
  const CounterIncrement();
  @override
  List<Object?> get props => [];
}

final class CounterDecrement extends CounterEvent {
  const CounterDecrement();
  @override
  List<Object?> get props => [];
}
