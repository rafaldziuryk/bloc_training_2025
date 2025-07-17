import 'package:equatable/equatable.dart';

enum CounterStatus { initial, loading, success, error }

class CounterState extends Equatable {
  final int count;
  final CounterStatus status;
  final String lastUpdated;

  const CounterState({
    this.count = 0,
    this.status = CounterStatus.initial,
    this.lastUpdated = '',
  });

  CounterState copyWith({
    int? count,
    CounterStatus? status,
    String? lastUpdated,
  }) {
    return CounterState(
      count: count ?? this.count,
      status: status ?? this.status,
      lastUpdated: lastUpdated ?? this.lastUpdated,
    );
  }

  @override
  List<Object> get props => [count, status, lastUpdated];
} 