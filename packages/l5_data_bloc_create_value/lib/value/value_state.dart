part of 'value_bloc.dart';

class ValueState extends Equatable {
  const ValueState(this.value);

  final int value;

  @override
  List<Object?> get props => [value];
}
