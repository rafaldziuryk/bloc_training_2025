import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:l5_data_bloc_create_value/create/create_bloc.dart';
import 'package:l5_data_bloc_create_value/value/value_bloc.dart';

class SecondPage extends StatefulWidget {
  const SecondPage({super.key, required this.createBloc, required this.valueBloc});

  final CreateBloc createBloc;
  final ValueBloc valueBloc;

  @override
  State<SecondPage> createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => widget.createBloc),
        BlocProvider.value(value: widget.valueBloc),
      ],
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text("L5 Data Bloc Create Value Second"),
        ),
        body: Center(
          child: BlocBuilder<CreateBloc, CreateState>(
            builder: (context, createState) {
              return BlocBuilder<ValueBloc, ValueState>(
                builder: (context, valueState) {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text("CREATE BLOCK VALUE: ${createState.value}"),
                      Text("VALUE BLOCK VALUE: ${valueState.value}"),
                    ],
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
