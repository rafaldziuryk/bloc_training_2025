part of 'keyboard_bloc.dart';

@immutable
sealed class KeyboardEvent extends Equatable {
  const KeyboardEvent();
}

final class NewCharKeyboardEvent extends KeyboardEvent {
  final dynamic value;

  const NewCharKeyboardEvent(this.value);
  @override
  List<Object?> get props => [value];
}
