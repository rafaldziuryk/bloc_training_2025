part of 'counter_plus_bloc.dart';

sealed class CounterPlusState extends Equatable {
  const CounterPlusState();
}

final class CounterPlusInitial extends CounterPlusState {
  @override
  List<Object> get props => [];
}
