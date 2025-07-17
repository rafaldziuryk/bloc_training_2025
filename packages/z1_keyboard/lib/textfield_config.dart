import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';

class TextfieldConfig extends Equatable{
  final TextEditingController controller;
  final String validation;

  const TextfieldConfig({
    required this.controller,
    this.validation = "",
  });

  
  TextfieldConfig copyWith({
    String? text,
    String? validation,
  }){
    return TextfieldConfig(
      controller: controller,
      validation: validation ?? this.validation,
    )..controller.text = text ?? controller.text;
  }
  
  @override
  List<Object?> get props => [controller.text, validation];
}