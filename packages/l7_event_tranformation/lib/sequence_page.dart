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
              switch (state.runtimeType) {
                case ValueCounterState:
                  final value = (state as ValueCounterState).counter;
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
                case CalculatingCounterState:
                  return const Center(child: CircularProgressIndicator());
                case InitialCounterState:
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
        floatingActionButton: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            FloatingActionButton(
              onPressed: () => context.read<CounterBloc>().add(CounterIncrement()),
              tooltip: 'Increment',
              child: const Icon(Icons.add),
            ),
            const SizedBox(height: 8),
            FloatingActionButton(
              onPressed: () => context.read<CounterBloc>().add(CounterDecrement()),
              tooltip: 'Decrement',
              child: const Icon(Icons.remove),
            ),
          ],
        ),
      ),
    );
  }
} 