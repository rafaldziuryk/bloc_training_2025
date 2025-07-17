import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:l11_bloc_watch/counter_bloc/counter_bloc.dart';
import 'package:l11_bloc_watch/counter_bloc/counter_event.dart';
import 'package:l11_bloc_watch/counter_bloc/counter_state.dart';
import 'package:l11_bloc_watch/user_bloc/user_bloc.dart';
import 'package:l11_bloc_watch/user_bloc/user_event.dart';
import 'package:l11_bloc_watch/user_bloc/user_state.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => CounterBloc()),
        BlocProvider(create: (context) => UserBloc()),
      ],
      child: MaterialApp(
        title: 'BLoC Watch Demo',
        theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple)),
        home: const HomePage(),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('BLoC Watch Demo'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'BlocProvider.watch()',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            
            // Using BlocProvider.watch()
            Builder(
              builder: (context) {
                final counterState = context.watch<CounterBloc>().state;
                final userState = context.watch<UserBloc>().state;
                
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Counter: ${counterState.count}'),
                    Text('User: ${userState.name} (${userState.age})'),
                  ],
                );
              },
            ),
            
            const SizedBox(height: 30),
            
            // Controls
            const Text('Controls:', style: TextStyle(fontWeight: FontWeight.w600)),
            const SizedBox(height: 12),
            
            Row(
              children: [
                ElevatedButton(
                  onPressed: () => context.read<CounterBloc>().add(CounterIncremented()),
                  child: const Text('+'),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () => context.read<CounterBloc>().add(CounterDecremented()),
                  child: const Text('-'),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () => context.read<CounterBloc>().add(CounterReset()),
                  child: const Text('Reset'),
                ),
              ],
            ),
            
            const SizedBox(height: 12),
            
            Row(
              children: [
                ElevatedButton(
                  onPressed: () => context.read<UserBloc>().add(const UserNameChanged('Alice')),
                  child: const Text('Name: Alice'),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () => context.read<UserBloc>().add(const UserNameChanged('Bob')),
                  child: const Text('Name: Bob'),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () => context.read<UserBloc>().add(const UserAgeChanged(30)),
                  child: const Text('Age: 30'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
