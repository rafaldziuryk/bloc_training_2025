import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';
import 'package:z1_keyboard/form_repository.dart';
import 'package:z1_keyboard/keyboard_functionals.dart';
import 'package:z1_keyboard/textfield_config.dart';

part 'form_event.dart';
part 'form_state.dart';

class FormBloc extends Bloc<FormEvent, InputFormState> {
  List<TextfieldConfig> textFields = [];
  final FormRepository formRepository;

  FormBloc({required this.formRepository}) : super(FormInitial()) {
    on<LoadEvent>(_onLoad);
    on<NewCharFormEvent>(_onNewChar);
  }

  FutureOr<void> _onLoad(LoadEvent event,Emitter<InputFormState> emit) async {
    emit(FormLoading());
    try {
      await formRepository.get(TextfieldConfig(controller: TextEditingController()));
      textFields = await formRepository.getTextFieldConfigs();
      emit(FormSuccess(
        // validations: List.generate(textFields.length, (index) => null), 
        textFields: textFields, 
        index: 0,
      ));
    } catch(e) {
      emit(FormFailure("$e"));
    }
    
  }

  FutureOr<void> _onNewChar(NewCharFormEvent event,Emitter<InputFormState> emit) {
    final value = event.value;

    final currentState = state;
    if (currentState is FormSuccess) {
      if (value is KeyboardFunctionals) {
        switch (value) {
          case KeyboardFunctionals.shift:
            break;
          case KeyboardFunctionals.up:
            final currentLength = currentState.textFields.length;
            emit(
              currentState.copyWith(
                index: (currentState.index - 1 + currentLength) % currentLength,
              ),
            );
          case KeyboardFunctionals.enter:
          case KeyboardFunctionals.down:
            emit(
              currentState.copyWith(
                index:
                    (currentState.index + 1) % currentState.textFields.length,
              ),
            );
          case KeyboardFunctionals.backspace:
            final newList = currentState.textFields;
            final oldText = newList[currentState.index].controller.text;
            newList[currentState.index] = newList[currentState.index].copyWith(
              text: oldText.substring(0,oldText.length - 1),
            );
            emit(currentState.copyWith(textFields: newList));
            
        }
      } else if (value is String) {
        final newList = currentState.textFields;
        final oldText = newList[currentState.index].controller.text;
        newList[currentState.index] = newList[currentState.index].copyWith(
          text: oldText + value,
        );
        emit(currentState.copyWith(textFields: newList));
      }
    }

  }
}
