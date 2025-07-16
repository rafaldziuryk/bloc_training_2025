part of 'create_bloc.dart';

class CreateState extends Equatable {
  const CreateState(this.value);

  final int value;

  @override
  List<Object?> get props => [value];
}
