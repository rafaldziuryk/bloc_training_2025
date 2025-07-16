import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:data_service/domain/product.dart';
import 'package:data_service/data/product_service_impl.dart';
import 'package:data_service/data/cart_service_impl.dart';
import 'data_bloc/data_bloc.dart';
import 'cart/cart_bloc.dart';

class DetailPage extends StatelessWidget {
  final String productId;

  const DetailPage({super.key, required this.productId});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => DataBloc(dataService: ProductServiceImpl())..add(LoadDataEvent()),
        ),
        BlocProvider(
          create: (context) => CartBloc(CartServiceImpl())..add(CartLoadEvent()),
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text("Szczegóły produktu"),
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
                  case DataSuccess(products: List<Product> products):
                    final product = products.firstWhere(
                      (p) => p.id == productId,
                      orElse: () => Product(id: '', name: 'Nie znaleziono', description: ''),
                    );
                    
                    if (product.id.isEmpty) {
                      return Center(child: Text('Produkt nie został znaleziony'));
                    }
                    
                    return Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            product.name,
                            style: Theme.of(context).textTheme.headlineMedium,
                          ),
                          SizedBox(height: 8),
                          Text(
                            product.description,
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                          SizedBox(height: 16),
                          Text(
                            'ID: ${product.id}',
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Colors.grey[600],
                            ),
                          ),
                          SizedBox(height: 24),
                          BlocBuilder<CartBloc, CartState>(
                            builder: (context, cartState) {
                              if (cartState is CartData) {
                                final quantity = cartState.cart[product] ?? 0;
                                return Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    ElevatedButton.icon(
                                      onPressed: () => context.read<CartBloc>().add(RemoveFromCartEvent(product)),
                                      icon: Icon(Icons.remove),
                                      label: Text('Usuń z koszyka'),
                                    ),
                                    Text(
                                      'Ilość: $quantity',
                                      style: Theme.of(context).textTheme.titleMedium,
                                    ),
                                    ElevatedButton.icon(
                                      onPressed: () => context.read<CartBloc>().add(AddToCartEvent(product)),
                                      icon: Icon(Icons.add),
                                      label: Text('Dodaj do koszyka'),
                                    ),
                                  ],
                                );
                              }
                              return SizedBox();
                            },
                          ),
                        ],
                      ),
                    );
                  case DataFailure():
                    return Center(child: Text(state.error, style: TextStyle(color: Colors.red)));
                }
              },
            );
          },
        ),
      ),
    );
  }
}
