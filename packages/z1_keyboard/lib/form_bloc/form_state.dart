part of 'form_bloc.dart';

@immutable
sealed class InputFormState extends Equatable{
  const InputFormState();
}

final class FormInitial extends InputFormState {

  const FormInitial();

  @override
  List<Object?> get props => [];
}

final class FormLoading extends InputFormState {
  const FormLoading();

  @override
  List<Object?> get props => [];
}

final class FormSuccess extends InputFormState {

  // final List<String?> validations;
  final List<TextfieldConfig> textFields;
  final int index;

  const FormSuccess({
    // required this.validations,
    required this.textFields,
    required this.index,
  });

  FormSuccess copyWith({
    List<String?>? validations,
    List<TextfieldConfig>? textFields,
    int? index,
  }) {
    return FormSuccess(
      // validations: validations ?? this.validations,
      textFields: textFields ?? this.textFields,
      index: index ?? this.index,
    );
  }

  @override
  List<Object?> get props => [ textFields, index];
}

final class FormFailure extends InputFormState {
  final String error;

  const FormFailure(this.error);

  @override
  List<Object?> get props => [error];
}
