part of 'counter_bloc.dart';

abstract class CounterEvent extends Equatable {
  const CounterEvent();
}

class CounterIncrement extends CounterEvent {
  @override
  List<Object?> get props => [];
}

class CounterDerement extends CounterEvent {
  @override
  List<Object?> get props => [];
}
