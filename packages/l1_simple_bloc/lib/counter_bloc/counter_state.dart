part of 'counter_bloc.dart';

final class CounterData extends Equatable {
  const CounterData(this.counter);

  final int counter;

  @override
  List<Object> get props => [counter];
}
