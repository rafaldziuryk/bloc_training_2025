import 'package:flutter/material.dart';
import 'package:z1_keyboard/keyboard_button_config.dart';
import 'package:z1_keyboard/keyboard_functionals.dart';

class StandardKeyboardKeys {
  static List<KeyboardButtonConfig> mainKeys = [
  ...List.generate(9, (index) {
    index++;
    return KeyboardButtonConfig(
      label: '$index',
      altLabel: String.fromCharCode(33 + index - 1), // !, @, #, ...
      value: String.fromCharCode(index),
      altValue: String.fromCharCode(33 + index - 1),
    );
  }),
    KeyboardButtonConfig(label: '0', altLabel: ')', value: "0", altValue: ')'),
  ];


  static Map<KeyboardFunctionals, KeyboardButtonConfig> specialKeys = {
    KeyboardFunctionals.shift: KeyboardButtonConfig(
      label: "shift",
      value: KeyboardFunctionals.shift,
    ),
    KeyboardFunctionals.backspace: KeyboardButtonConfig(
      label: '',
      altLabel: 'DEL',
      value: KeyboardFunctionals.backspace,
      altValue: 'DEL',
      icon: Icons.backspace,
    ),
    KeyboardFunctionals.enter: KeyboardButtonConfig(
      label: '',
      altLabel: 'OK',
      value: KeyboardFunctionals.enter,
      altValue: 'OK',
      icon: Icons.check,
    ),
    KeyboardFunctionals.up: KeyboardButtonConfig(
      label: '',
      altLabel: 'PgUp',
      value: KeyboardFunctionals.up,
      altValue: 'PgUp',
      icon: Icons.arrow_upward,
    ),
    KeyboardFunctionals.down: KeyboardButtonConfig(
      label: '',
      altLabel: 'PgDn',
      value: KeyboardFunctionals.down,
      altValue: 'PgDn',
      icon: Icons.arrow_downward,
    ),
  };
}




