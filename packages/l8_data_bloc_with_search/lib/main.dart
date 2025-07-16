import 'package:data_service/data/product_service_impl.dart';
import 'package:data_service/domain/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:l8_data_bloc_with_search/data_bloc/data_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple)),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DataBloc(dataService: ProductServiceImpl())..add(LoadDataEvent()),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text("L8 Data BLoC with Search"),
        ),
        body: Builder(
          builder: (context) {
            final controller = TextEditingController();
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: controller,
                    decoration: const InputDecoration(
                      labelText: 'Wyszukaj',
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value) {
                      context.read<DataBloc>().add(SearchEvent(value));
                    },
                  ),
                ),
                Expanded(
                  child: BlocBuilder<DataBloc, DataState>(
                    builder: (context, state) {
                      switch (state) {
                        case DataInitial():
                          return SizedBox();
                        case DataLoading():
                          return Center(child: CircularProgressIndicator());
                        case DataSuccess(products: List<Product> products):
                          return ListView.builder(
                            itemCount: products.length,
                            itemBuilder: (context, index) {
                              final item = products[index];
                              return ListTile(
                                title: Text(item.name),
                                subtitle: Text(item.description),
                                leading: Text(item.id),
                              );
                            },
                          );
                        case DataFailure():
                          return Center(child: Text(state.error, style: TextStyle(color: Colors.red)));
                      }
                    },
                  ),
                ),
              ],
            );
          },
        ),
        floatingActionButton: Builder(
          builder: (context) {
            return FloatingActionButton(
              onPressed: () => context.read<DataBloc>().add(LoadDataEvent()),
              tooltip: 'Reload Data',
              child: const Icon(Icons.refresh),
            );
          },
        ),
      ),
    );
  }
}
