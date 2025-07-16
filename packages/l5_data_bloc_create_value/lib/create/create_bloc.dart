import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'create_event.dart';

part 'create_state.dart';

class CreateBloc extends Bloc<CreateEvent, CreateState> {
  CreateBloc() : super(CreateState(0)) {
    on<CreateEvent>(onCreate);
  }

  FutureOr<void> onCreate(CreateEvent event, Emitter<CreateState> emit) async {
    await emit.forEach(
      Stream.periodic(Duration(seconds: 1), (computationCount) {
        return computationCount;
      }),
      onData: (data) => CreateState(data),
    );
  }

  @override
  Future<void> close() {
    return super.close();
  }
}
