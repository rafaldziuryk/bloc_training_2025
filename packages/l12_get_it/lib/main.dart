import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:l12_get_it/di.dart';
import 'package:l12_get_it/cart_bloc/cart_bloc.dart';
import 'package:l12_get_it/cart_bloc/cart_event.dart';
import 'package:l12_get_it/list_page.dart';

void main() {
  setupDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<CartBloc>()..add(CartLoadEvent()),
      child: MaterialApp(
        title: 'GetIt Demo',
        theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple)),
        home: const ListPage(),
      ),
    );
  }
}
