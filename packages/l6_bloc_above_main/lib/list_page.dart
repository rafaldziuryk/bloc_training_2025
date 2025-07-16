import 'package:data_service/data/product_service_impl.dart';
import 'package:data_service/domain/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:l6_bloc_above_main/data_bloc/data_bloc.dart';
import 'package:l6_bloc_above_main/cart_bloc/cart_bloc.dart';
import 'detail_page.dart';

class ListPage extends StatelessWidget {
  const ListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DataBloc(dataService: ProductServiceImpl(), cartService: context.read<CartBloc>().cartService)..add(LoadDataEvent()),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text("L6 Data BLoC"),
        ),
        body: Builder(
          builder: (context) {
            return BlocBuilder<DataBloc, DataState>(
              builder: (context, state) {
                switch (state) {
                  case DataInitial():
                    return SizedBox();
                  case DataLoading():
                    return Center(child: CircularProgressIndicator());
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
                                padding: EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: Theme.of(context).primaryColor,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  '${item.value}',
                                  style: TextStyle(
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
                    return Center(child: Text(state.error, style: TextStyle(color: Colors.red)));
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