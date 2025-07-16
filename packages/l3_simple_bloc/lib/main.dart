import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:l3_simple_bloc/counter_bloc/counter_bloc.dart';
import 'package:l3_simple_bloc/product/product_bloc.dart';

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
      create: (context) => ProductBloc(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(widget.title),
        ),
        body: Builder(
          builder: (context) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  TextField(
                    onSubmitted: (value) => context.read<ProductBloc>()..add(ProductAdd(product: value)),
                  ),
                  const Text('Product list:'),
                  Expanded(
                    child: BlocBuilder<ProductBloc, ProductState>(
                      builder: (context, state) {
                        switch (state) {
                          case ProductList(products: final products):
                            return ListView.builder(
                              itemCount: products.length,
                              itemBuilder: (context, index) {
                                return ListTile(
                                  title: Text(products[index]),
                                  trailing: CloseButton(
                                    onPressed: ()=> context.read<ProductBloc>()..add(ProductDelete(product: products[index])),
                                  ),
                                );
                              },
                            );
                        }
                      },
                    ),
                  ),
                ],
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
