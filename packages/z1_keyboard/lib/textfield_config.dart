import 'package:equatable/equatable.dart';

class TextfieldConfig extends Equatable{
  final String text;
  final String validation;

  const TextfieldConfig({
    required this.text,
    this.validation = "",
  });

  
  TextfieldConfig copyWith({
    String? text,
    String? validation,
  }){
    return TextfieldConfig(
      text: text ?? this.text,
      validation: validation ?? this.validation,
    );
  }
  
  @override
  List<Object?> get props => [text, validation];
}