import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'sequence_bloc/counter_bloc.dart';

class SequencePage extends StatelessWidget {
  const SequencePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CounterBloc(),
      child: Scaffold(
        appBar: AppBar(title: const Text('Sequence Counter')),
        body: Center(
          child: BlocBuilder<CounterBloc, CounterState>(
            builder: (context, state) {
              switch (state) {
                case final ValueCounterState valueState:
                  final value = valueState.counter;
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('You have pushed the button this many times:'),
                      Text(
                        value.toString(),
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                    ],
                  );
                case const CalculatingCounterState():
                  return const Center(child: CircularProgressIndicator());
                case const InitialCounterState():
                default:
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('You have pushed the button this many times:'),
                      Text(
                        '0',
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                    ],
                  );
              }
            },
          ),
        ),
        floatingActionButton: Builder(
          builder: (context) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                FloatingActionButton(
                  heroTag: "increment",
                  onPressed: () => context.read<CounterBloc>().add(CounterIncrement()),
                  tooltip: 'Increment',
                  child: const Icon(Icons.add),
                ),
                const SizedBox(height: 8),
                FloatingActionButton(
                  heroTag: "decrement",
                  onPressed: () => context.read<CounterBloc>().add(CounterDecrement()),
                  tooltip: 'Decrement',
                  child: const Icon(Icons.remove),
                ),
              ],
            );
          }
        ),
      ),
    );
  }
} 