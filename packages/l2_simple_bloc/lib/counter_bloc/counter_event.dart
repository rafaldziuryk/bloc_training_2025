part of 'counter_bloc.dart';

sealed class CounterEvent extends Equatable {
  const CounterEvent();
}

class IncrementCounterEvent extends CounterEvent {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class DecrementCounterEvent extends CounterEvent {
  @override
  List<Object?> get props => throw UnimplementedError();
}
