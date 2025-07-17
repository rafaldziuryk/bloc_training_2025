import 'package:flutter/material.dart';
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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            for (int i = 0; i < 5; i++)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 32.0),
                child: TextField(
                  decoration: InputDecoration(
                    labelText: 'Pole ${i + 1}',
                    border: const OutlineInputBorder(),
                  ),
                ),
              ),
            const SizedBox(height: 32),
            NumericKeyboard(
              onDigitPressed: (digit) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Wciśnięto cyfrę: $digit')),
                );
              },
              onAltPressed: (alt) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Wciśnięto ALT: $alt')),
                );
              },
              onArrowUp: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Wciśnięto strzałkę w górę')),
                );
              },
              onArrowDown: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Wciśnięto strzałkę w dół')),
                );
              },
              onBackspace: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Wciśnięto backspace')),
                );
              },
              onSubmit: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Wciśnięto zatwierdź')),
                );
              },
              altDigits: const {
                1: '!',
                2: '@',
                3: '#',
                4: ' 24',
                5: '%',
                6: '^',
                7: '&',
                8: '*',
                9: '(',
                0: ')',
              },
              altBackspace: 'DEL',
              altSubmit: 'OK',
              altArrowUp: 'PgUp',
              altArrowDown: 'PgDn',
            ),
          ],
        ),
      ),
    );
  }
}
