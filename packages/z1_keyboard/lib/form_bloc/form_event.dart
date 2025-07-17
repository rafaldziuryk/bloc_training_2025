part of 'form_bloc.dart';

@immutable
sealed class FormEvent extends Equatable {
  const FormEvent();
}

final class LoadEvent extends FormEvent {
  @override
  List<Object?> get props => [];
}

final class NewCharFormEvent extends FormEvent {
  final dynamic value;

  const NewCharFormEvent({required this.value});

  @override
  List<Object?> get props => [value];
}
