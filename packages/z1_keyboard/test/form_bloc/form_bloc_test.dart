import 'package:flutter/material.dart';
import 'package:mocktail/mocktail.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:z1_keyboard/form_bloc/form_bloc.dart';
import 'package:z1_keyboard/keyboard_functionals.dart';
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

  setUpAll(() {
    registerFallbackValue(TextfieldConfig(controller: TextEditingController()));
  });

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
      verify: (_) {
        verifyNever(() => formRepository.getTextFieldConfigs(),);
        // verify(() => formRepository.getTextFieldConfigs(),).called(0); // jesli nie ma wywolan to nie dawac called 0 tylko verifyNever
        verifyNoMoreInteractions(formRepository);
      }
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

    blocTest<FormBloc, InputFormState>(
      "remove char ",
      // seed: () => FormSuccess(textFields: textEditConfigs, index: 0), 
      setUp: () => formRepository.mockSuccess(["5",""]),
      build: () => formBloc,
      act: (bloc) {
        bloc.add(LoadEvent());
        bloc.add(NewCharFormEvent(value: KeyboardFunctionals.backspace));
      },
      expect: () => [
        FormLoading(),
        FormSuccess(textFields: textEditConfigs, index: 0)
      ],
      verify: (_) {
        verify(() => formRepository.getTextFieldConfigs(),).called(1);
        verifyNoMoreInteractions(formRepository);
      }
    );


    blocTest<FormBloc, InputFormState>(
      "go up",
      // seed: () => FormSuccess(textFields: textEditConfigs, index: 0), 
      setUp: () => formRepository.mockSuccess(["","", ""]),
      build: () => formBloc,
      act: (bloc) {
        bloc.add(LoadEvent());
        bloc.add(NewCharFormEvent(value: KeyboardFunctionals.up));
      },
      expect: () => [
        FormLoading(),
        FormSuccess(textFields: [
          TextfieldConfig(controller: TextEditingController(text: "")),
          TextfieldConfig(controller: TextEditingController(text: "")),
          TextfieldConfig(controller: TextEditingController(text: "")),
        ], index: 0),
        FormSuccess(textFields: [
          TextfieldConfig(controller: TextEditingController(text: "")),
          TextfieldConfig(controller: TextEditingController(text: "")),
          TextfieldConfig(controller: TextEditingController(text: "")),
        ], index: 2),
      ],
    );

    blocTest<FormBloc, InputFormState>(
      "go down",
      // seed: () => FormSuccess(textFields: textEditConfigs, index: 0), 
      setUp: () => formRepository.mockSuccess(["","", ""]),
      build: () => formBloc,
      act: (bloc) {
        bloc.add(LoadEvent());
        bloc.add(NewCharFormEvent(value: KeyboardFunctionals.down));
      },
      expect: () => [
        FormLoading(),
        FormSuccess(textFields: [
          TextfieldConfig(controller: TextEditingController(text: "")),
          TextfieldConfig(controller: TextEditingController(text: "")),
          TextfieldConfig(controller: TextEditingController(text: "")),
        ], index: 0),
        FormSuccess(textFields: [
          TextfieldConfig(controller: TextEditingController(text: "")),
          TextfieldConfig(controller: TextEditingController(text: "")),
          TextfieldConfig(controller: TextEditingController(text: "")),
        ], index: 1),
      ],
    );



    blocTest<FormBloc, InputFormState>(
      "test",
      setUp: () => when(() => formRepository.get(any()),).thenAnswer((_) async => []),
      build: () => formBloc,
      act: (bloc) {
        bloc.add(LoadEvent());
        bloc.add(NewCharFormEvent(value: KeyboardFunctionals.down));
      },
      expect: () => [
      ],
    );

  },);


}

