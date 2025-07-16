import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:data_service/data/cart_service_impl.dart';
import 'package:l6_bloc_above_main/list_page.dart';
import 'package:l6_bloc_above_main/cart_bloc/cart_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CartBloc(CartServiceImpl())..add(CartLoadEvent()),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
        ),
        home: const ListPage(),
      ),
    );
  }
}