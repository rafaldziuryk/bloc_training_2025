import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:l5_data_bloc_create_value/create/create_bloc.dart';
import 'package:l5_data_bloc_create_value/second_page.dart';
import 'package:l5_data_bloc_create_value/value/value_bloc.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => CreateBloc()..add(CreateEvent())),
        BlocProvider.value(value: ValueBloc()..add(ValueEvent())),
      ],
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text("L5 Data Bloc Create Value First"),
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
                      OutlinedButton(
                        onPressed:
                            () => Navigator.of(context).push(
                              MaterialPageRoute(
                                builder:
                                    (routeContext) => SecondPage(
                                      createBloc: context.read(),
                                      valueBloc: context.read(),
                                    ),
                              ),
                            ),
                        child: Text("Go To Second page"),
                      ),
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
