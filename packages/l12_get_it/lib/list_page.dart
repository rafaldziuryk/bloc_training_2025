import 'package:data_service/domain/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:l12_get_it/di.dart';
import 'package:l12_get_it/data_bloc/data_bloc.dart';
import 'package:l12_get_it/data_bloc/data_event.dart';
import 'package:l12_get_it/data_bloc/data_state.dart';
import 'package:l12_get_it/detail_page.dart';

class ListPage extends StatelessWidget {
  const ListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<DataBloc>()..add(LoadDataEvent()),
      // create: (context) => sl<DataBloc>()..add(LoadDataEvent()),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: const Text("GetIt Demo"),
        ),
        body: Builder(
          builder: (context) {
            return BlocBuilder<DataBloc, DataState>(
              builder: (context, state) {
                switch (state) {
                  case DataInitial():
                    return const SizedBox();
                  case DataLoading():
                    return const Center(child: CircularProgressIndicator());
                  case DataSuccess(products: Map<Product, int> products):
                    return ListView.builder(
                      itemCount: products.length,
                      itemBuilder: (context, index) {
                        final item = products.entries.toList()[index];
                        return ListTile(
                          title: Text(item.key.name),
                          subtitle: Text(item.key.description),
                          leading: Text(item.key.id),
                          trailing: item.value > 0
                            ? Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: Theme.of(context).primaryColor,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  '${item.value}',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              )
                            : null,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DetailPage(productId: item.key.id),
                              ),
                            );
                          },
                        );
                      },
                    );
                  case DataFailure():
                    return Center(child: Text(state.error, style: const TextStyle(color: Colors.red)));
                  default:
                    return const SizedBox();
                }
              },
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