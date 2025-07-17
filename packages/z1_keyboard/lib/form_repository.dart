
import 'package:flutter/material.dart';
import 'package:z1_keyboard/textfield_config.dart';

class FormRepository {

  Future<List<TextfieldConfig>> getTextFieldConfigs() async {
    return Future.delayed(Duration(milliseconds: 500), () => [
      TextfieldConfig(controller:  TextEditingController(text: "")),
      TextfieldConfig(controller:  TextEditingController(text: "")),
      TextfieldConfig(controller:  TextEditingController(text: "")),
      TextfieldConfig(controller:  TextEditingController(text: "")),
      TextfieldConfig(controller:  TextEditingController(text: "")),
    ],);
  } 

  Future<List<TextfieldConfig>> get(TextfieldConfig textFieldConfig) async {
    return Future.delayed(Duration(milliseconds: 500), () => [
      textFieldConfig
],);
  } 
}