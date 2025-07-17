import 'package:flutter/widgets.dart';
import 'package:z1_keyboard/form_repository.dart';
import 'package:mocktail/mocktail.dart';
import 'package:z1_keyboard/textfield_config.dart';

class FormRepositoryMock extends Mock implements FormRepository {

  mockSuccess(List<String> textList){
    when(()=> getTextFieldConfigs()).thenAnswer(
          (_) async => textList.map((e) => TextfieldConfig(controller:  TextEditingController(text: e)),).toList(),
        );
  }

  mockFail(String error){
    when(()=> getTextFieldConfigs()).thenThrow(Exception(error));
  }
}