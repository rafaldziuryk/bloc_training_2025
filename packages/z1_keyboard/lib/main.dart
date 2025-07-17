import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:z1_keyboard/form_bloc/form_bloc.dart';
import 'package:z1_keyboard/form_repository.dart';
import 'package:z1_keyboard/keyboard_bloc/keyboard_bloc.dart';
import 'package:z1_keyboard/keyboard_functionals.dart';
import 'numeric_keyboard.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => KeyboardBloc()),
        BlocProvider(create: (context) => FormBloc(formRepository: FormRepository())..add(LoadEvent())),
      ],
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(widget.title),
          actions: [
            BlocBuilder<KeyboardBloc, KeyboardState>(
              builder: (context, state) {
                return Text(state.type.toString());
              },
            ),
          ],
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: BlocConsumer<FormBloc, InputFormState>(
                  listener: (context, state) {
                    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                      setState(() {
                        
                      });
                    },);
                  },
                  builder: (context, state) {
                    return switch(state) {
                      FormInitial() => SizedBox(),
                      FormLoading() => Center(
                        child: CircularProgressIndicator(),
                      ),
                      FormSuccess() => Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: state.textFields.mapIndexed((index, element) {
                          return Container(
                            color: index == state.index ? Colors.amberAccent : Colors.white,
                            padding: const EdgeInsets.symmetric(
                              vertical: 8.0,
                              horizontal: 32.0,
                            ),
                            child: Text(
                              state.textFields[index].text,
                              // decoration: InputDecoration(
                              //   labelText: 'Pole ${index + 1}',
                              //   border: const OutlineInputBorder(),
                              // ),
                            ),
                          );
                        },).toList()),              
                      FormFailure() => Center(child: Text(state.error, style: TextStyle(color: Colors.red),),),
                    };
                  },
                ),
              ),
              const SizedBox(height: 32),
              BlocBuilder<KeyboardBloc, KeyboardState>(
                builder: (context, KeyboardState state) {
                  return NumericKeyboard(
                    buttons: [
                      state.specialKeys[KeyboardFunctionals.shift]!,
                      ...state.mainKeys,
                      state.specialKeys[KeyboardFunctionals.backspace]!,
                      state.specialKeys[KeyboardFunctionals.enter]!,
                      state.specialKeys[KeyboardFunctionals.up]!,
                      state.specialKeys[KeyboardFunctionals.down]!,
                    ],
                    onPressed: (value) {
                      context.read<KeyboardBloc>().add(NewCharKeyboardEvent(value));
                      context.read<FormBloc>().add(NewCharFormEvent(value: value));
                    },
                    onAltPressed: (alt) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Wciśnięto ALT: $alt')),
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
