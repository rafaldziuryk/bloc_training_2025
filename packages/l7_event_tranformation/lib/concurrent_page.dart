import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'concurrent_bloc/counter_bloc.dart';

class ConcurrentPage extends StatelessWidget {
  const ConcurrentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CounterBloc(),
      child: Scaffold(
        appBar: AppBar(title: const Text('Concurrent Counter')),
        body: Center(
          child: BlocBuilder<CounterBloc, CounterState>(
            builder: (context, state) {
              int? value;
              bool calculating = false;
              if (state is ValueCounterState) {
                value = state.counter;
              } else if (state is CalculatingCounterState) {
                calculating = true;
              } else if (state is InitialCounterState) {
                value = 0;
              }
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('You have pushed the button this many times:'),
                  calculating
                      ? const CircularProgressIndicator()
                      : Text(
                          (value ?? 0).toString(),
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                ],
              );
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
              onPressed: () => context.read<CounterBloc>().add(CounterDerement()),
              tooltip: 'Decrement',
              child: const Icon(Icons.remove),
            ),
          ],
        ),
      ),
    );
  }
} 