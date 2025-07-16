import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'value_event.dart';

part 'value_state.dart';

class ValueBloc extends Bloc<ValueEvent, ValueState> {
  ValueBloc() : super(ValueState(0)) {
    on<ValueEvent>((event, emit) async {
      await emit.forEach(
        Stream.periodic(Duration(seconds: 1), (computationCount) {
          return computationCount;
        }),
        onData: (data) => ValueState(data),
      );
    });
    subscription = Stream.periodic(Duration(seconds: 1)).listen((event) {
      add(ValueEvent());
    });
  }

  late final StreamSubscription subscription;

  @override
  Future<void> close() {
    // subscription.cancel();
    return super.close();
  }
}
