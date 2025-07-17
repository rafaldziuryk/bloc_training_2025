import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:z1_keyboard/alternative_keyboard_keys.dart';
import 'package:z1_keyboard/keyboard_button_config.dart';
import 'package:z1_keyboard/keyboard_functionals.dart';
import 'package:z1_keyboard/keyboard_type.dart';
import 'package:z1_keyboard/standard_keyboard_keys.dart';

part 'keyboard_event.dart';
part 'keyboard_state.dart';


class KeyboardBloc extends Bloc<KeyboardEvent, KeyboardState> {
  KeyboardBloc() : super(KeyboardState(
    type: KeyboardType.standard,
    mainKeys: StandardKeyboardKeys.mainKeys,
    specialKeys: StandardKeyboardKeys.specialKeys,
  )) {
    on<NewCharKeyboardEvent>(_onKeyboardChange);
  }

  FutureOr<void> _onKeyboardChange(NewCharKeyboardEvent event,Emitter<KeyboardState> emit) {
    if(event.value is KeyboardFunctionals && event.value == KeyboardFunctionals.shift) {

      final newType = KeyboardType.values[(KeyboardType.values.indexOf(state.type)+1) % KeyboardType.values.length];

      final newKeys = switch(newType){
        KeyboardType.standard => StandardKeyboardKeys.mainKeys,
        KeyboardType.alternative => AlternativeKeyboardKeys.mainKeys,
      };

      emit(state.copyWith(
        type: newType,
        mainKeys: newKeys,
      ));
    }  
  }
}
