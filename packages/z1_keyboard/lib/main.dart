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
              buttons: [
                for (var i = 1; i <= 9; i++)
                  KeyboardButtonConfig(
                    label: '$i',
                    altLabel: String.fromCharCode(33 + i - 1), // !, @, #, ...
                    value: i,
                    altValue: String.fromCharCode(33 + i - 1),
                  ),
                KeyboardButtonConfig(
                  label: '0',
                  altLabel: ')',
                  value: 0,
                  altValue: ')',
                ),
                KeyboardButtonConfig(
                  label: '',
                  altLabel: 'DEL',
                  value: 'backspace',
                  altValue: 'DEL',
                  icon: Icons.backspace,
                ),
                KeyboardButtonConfig(
                  label: '',
                  altLabel: 'OK',
                  value: 'submit',
                  altValue: 'OK',
                  icon: Icons.check,
                ),
                KeyboardButtonConfig(
                  label: '',
                  altLabel: 'PgUp',
                  value: 'up',
                  altValue: 'PgUp',
                  icon: Icons.arrow_upward,
                ),
                KeyboardButtonConfig(
                  label: '',
                  altLabel: 'PgDn',
                  value: 'down',
                  altValue: 'PgDn',
                  icon: Icons.arrow_downward,
                ),
              ],
              onPressed: (value) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Wciśnięto: $value')),
                );
              },
              onAltPressed: (alt) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Wciśnięto ALT: $alt')),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
