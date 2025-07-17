import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:l11_bloc_watch/user_bloc/user_event.dart';
import 'package:l11_bloc_watch/user_bloc/user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(const UserState()) {
    on<UserNameChanged>(_onNameChanged);
    on<UserAgeChanged>(_onAgeChanged);
  }

  void _onNameChanged(UserNameChanged event, Emitter<UserState> emit) {
    emit(state.copyWith(name: event.name));
  }

  void _onAgeChanged(UserAgeChanged event, Emitter<UserState> emit) {
    emit(state.copyWith(age: event.age));
  }
} 