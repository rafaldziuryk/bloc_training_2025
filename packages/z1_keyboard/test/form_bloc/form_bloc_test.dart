import 'package:flutter/material.dart';
import 'package:mocktail/mocktail.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:z1_keyboard/form_bloc/form_bloc.dart';
import 'package:z1_keyboard/textfield_config.dart';

import '../form_repository_mock.dart';

void main() {
  late FormRepositoryMock formRepository;
  late FormBloc formBloc;

  final tec1 = TextEditingController(text: "");
  final tec2 = TextEditingController(text: "");
  final textEditConfigs = [
    TextfieldConfig(controller: tec1),
    TextfieldConfig(controller: tec2),
  ];

  setUp(() {
    formRepository = FormRepositoryMock();
    formBloc = FormBloc(formRepository: formRepository);
  });

  // setupall

  tearDown(() {
    formBloc.close();
  },);


  group("input test", () {
    blocTest<FormBloc, InputFormState>(
      "no action", 
      setUp: () {
        when(()=> formRepository.getTextFieldConfigs()).thenAnswer(
          (_) async => [
            TextfieldConfig(controller:  tec1),
            TextfieldConfig(controller:  tec2),
          ],
        );
      },
      build: () => formBloc,
      expect: () => [
        
      ],
    );

    blocTest<FormBloc, InputFormState>(
      "load", 
      setUp: () => formRepository.mockSuccess(["",""]),
      build: () => formBloc,
      act: (bloc) => bloc.add(LoadEvent()),
      expect: () => [
        FormLoading(),
        FormSuccess(textFields: [
            TextfieldConfig(controller:  TextEditingController(text: "")),
            TextfieldConfig(controller:  TextEditingController(text: "")),
          ], index: 0),
      ],
    );

    blocTest<FormBloc, InputFormState>(
      "load failure", 
      setUp: () => formRepository.mockFail("connection lost"),
      build: () => formBloc,
      act: (bloc) => bloc.add(LoadEvent()),
      expect: () => [
        FormLoading(),
        FormFailure("Exception: connection lost"),
      ],
    );

    blocTest<FormBloc, InputFormState>(
      "add char - not initialized", 
      build: () => formBloc,
      act: (bloc) => bloc.add(NewCharFormEvent(value: "5")),
      expect: () => [
      ],
    );

    blocTest<FormBloc, InputFormState>(
      "add char ",
      // seed: () => FormSuccess(textFields: textEditConfigs, index: 0), 
      setUp: () => formRepository.mockSuccess(["",""]),
      build: () => formBloc,
      act: (bloc) {
        bloc.add(LoadEvent());
        bloc.add(NewCharFormEvent(value: "5"));
      },
      expect: () => [
        FormLoading(),
        FormSuccess(textFields: [
          TextfieldConfig(controller: TextEditingController(text: "5")),
          textEditConfigs[1],
        ], index: 0)
      ],
    );

  },);


}

