import 'dart:math';

import 'package:data_service/data/products.dart';
import 'package:data_service/domain/product_service.dart';
import 'package:data_service/domain/product.dart';
import 'package:data_service/domain/query_input.dart';
import 'package:rxdart/rxdart.dart';

class ProductServiceImpl extends ProductService {
  final Random random = Random();
  final BehaviorSubject<List<Product>> _productDataStream = BehaviorSubject.seeded(products);

  @override
  Future<List<Product>> getProducts(QueryInput input) async {
    await Future.delayed(Duration(seconds: 1));

    final error = random.nextDouble() < 0.2;

    if (error) {
      return Future.error("Error");
    }

    return products.where((element) => filter(element, input)).toList();
  }

  @override
  Stream<List<Product>> get productStream => _productDataStream.stream;


  @override
  void add(Product product) {
    products.add(product);
    final copy = List.of(products);
    _productDataStream.add(copy);
  }

  @override
  void remove(Product product) {
    products.remove(product);
    final copy = List.of(products);
    _productDataStream.add(copy);
  }}
