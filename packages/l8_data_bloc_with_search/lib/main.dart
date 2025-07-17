import 'package:data_service/data/product_service_impl.dart';
import 'package:data_service/domain/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:l8_data_bloc_with_search/data_bloc/data_bloc.dart';
import 'package:l8_data_bloc_with_search/search/search_bloc.dart';

// nazwa i opis +
// 2 textfielde min max i bedziemy filtrowac po id od min do max

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

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _nameController = TextEditingController();
  final _fromController = TextEditingController();
  final _toController = TextEditingController();

  final _dataSerivce = ProductServiceImpl();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => DataBloc(dataService: _dataSerivce)..add(LoadDataEvent()),
        ),
        BlocProvider(create: (context) => SearchBloc(dataService: _dataSerivce)),
      ],
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text("L8 Data BLoC with Search"),
        ),
        body: Builder(
          builder: (context) {
            return BlocListener<SearchBloc, SearchState>(
              listener: (context, state) {
                context.read<DataBloc>().add(LoadDataEvent());
              },
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: _nameController,
                      decoration: const InputDecoration(
                        labelText: 'Wyszukaj',
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (value) {
                        // context.read<DataBloc>().add(SearchEvent(value, _fromController.text, _toController.text));
                        context.read<SearchBloc>().add(QueryEvent(query: value));
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      spacing: 20.0,
                      children: [
                        Flexible(
                          child: TextField(
                            controller: _fromController,
                            decoration: InputDecoration(
                              hintText: "0",
                              labelText: 'od',
                              border: OutlineInputBorder(),
                            ),
                            onChanged: (value) {
                              context.read<SearchBloc>().add(FromEvent(from: value));
                              // context.read<DataBloc>().add(SearchEvent(_nameController.text, value, _toController.text));
                            },
                          ),
                        ),
                        BlocSelector<DataBloc, DataState, String>(
                          selector: (state) {
                            return state is DataSuccess ? state.products.length.toString() : "0";
                          },
                          builder: (context, state) {
                            return Flexible(
                              child: TextField(
                                controller: _toController,
                                decoration: InputDecoration(
                                  hintText: state,
                                  labelText: 'do',
                                  border: OutlineInputBorder(),
                                ),
                                onChanged: (value) {
                                  context.read<SearchBloc>().add(ToEvent(to: value));
                                  // context.read<DataBloc>().add(SearchEvent(_nameController.text, _fromController.text, value));
                                },
                              ),
                            );
                          },
                        ),
                      ],
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
                            return Center(
                              child: Text(state.error, style: TextStyle(color: Colors.red)),
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
