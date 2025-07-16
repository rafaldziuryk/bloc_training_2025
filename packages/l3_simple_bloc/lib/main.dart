import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:l3_simple_bloc/counter_bloc/counter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple)),
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
    return BlocProvider(
      create: (context) => CounterBloc(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(widget.title),
        ),
        body: Builder(
          builder: (context) {
            return BlocListener<CounterBloc, CounterState>(
              listenWhen: (previous, current) => current is CounterData,
              listener: (context, state) {
                final counter = (state as CounterData).counter;
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(counter.toString()), duration: Duration(microseconds: 300),));
                },
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text('You have pushed the button this many times:'),
                    BlocBuilder<CounterBloc, CounterState>(
                      builder: (context, state) {
                        switch (state) {
                          case CounterData(counter: int counter):
                            return Text(
                              counter.toString(),
                              style: Theme.of(context).textTheme.headlineMedium,
                            );
                          case CounterCalculating():
                            return CircularProgressIndicator();
                        }
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        ),
        floatingActionButton: Builder(
          builder: (context) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                FloatingActionButton(
                  heroTag: "increment",
                  onPressed: () => context.read<CounterBloc>().add(IncrementCounterEvent()),
                  tooltip: 'Increment',
                  child: const Icon(Icons.add),
                ),
                FloatingActionButton(
                  heroTag: "decrement",
                  onPressed: () => context.read<CounterBloc>().add(DecrementCounterEvent()),
                  tooltip: 'Decrement',
                  child: const Icon(Icons.remove),
                ),
              ],
            );
          },
        ), // This trailing comma makes auto-formatting nicer for build methods.
      ),
    );
  }
}
