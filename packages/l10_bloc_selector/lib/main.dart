import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:l10_bloc_selector/counter_bloc/counter_bloc.dart';
import 'package:l10_bloc_selector/counter_bloc/counter_event.dart';
import 'package:l10_bloc_selector/counter_bloc/counter_state.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CounterBloc()..add(CounterStarted()),
      child: MaterialApp(
        title: 'BLoCSelector Demo',
        theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple)),
        home: const CounterPage(),
      ),
    );
  }
}

class CounterPage extends StatelessWidget {
  const CounterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('BLoCSelector Demo'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'BLoCSelector vs BlocBuilder',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            
            // BlocBuilder - rebuilds on any state change
            const Text('1. BlocBuilder:', style: TextStyle(fontWeight: FontWeight.w600)),
            const SizedBox(height: 8),
            BlocBuilder<CounterBloc, CounterState>(
              builder: (context, state) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Counter: ${state.count}'),
                    Text('Status: ${state.status.name}'),
                  ],
                );
              },
            ),
            
            const SizedBox(height: 20),
            
            // BlocSelector - rebuilds only when count changes
            const Text('2. BlocSelector (count only):', style: TextStyle(fontWeight: FontWeight.w600)),
            const SizedBox(height: 8),
            BlocSelector<CounterBloc, CounterState, int>(
              selector: (state) => state.count,
              builder: (context, count) {
                return Text('Counter: $count');
              },
            ),
            
            const SizedBox(height: 20),
            
            // BlocSelector - rebuilds only when status changes
            const Text('3. BlocSelector (status only):', style: TextStyle(fontWeight: FontWeight.w600)),
            const SizedBox(height: 8),
            BlocSelector<CounterBloc, CounterState, CounterStatus>(
              selector: (state) => state.status,
              builder: (context, status) {
                return Text('Status: ${status.name}');
              },
            ),
            
            const SizedBox(height: 30),
            
            // Controls
            Row(
              children: [
                ElevatedButton(
                  onPressed: () => context.read<CounterBloc>().add(CounterIncremented()),
                  child: const Text('+'),
                ),
                const SizedBox(width: 12),
                ElevatedButton(
                  onPressed: () => context.read<CounterBloc>().add(CounterDecremented()),
                  child: const Text('-'),
                ),
                const SizedBox(width: 12),
                ElevatedButton(
                  onPressed: () => context.read<CounterBloc>().add(CounterReset()),
                  child: const Text('Reset'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
