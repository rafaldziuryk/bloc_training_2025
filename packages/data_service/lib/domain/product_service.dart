import 'package:data_service/domain/product.dart';
import 'package:data_service/domain/query_input.dart';

abstract class ProductService {
  Future<List<Product>> getProducts();

  // Stream<List<Product>> get productStream;
  // Stream<List<Product>> get filteredProductStream;
  // Stream<List<QueryInput>> get filteredStream;

  List<QueryInput> filterList = [
    NameDescriptionQueryInput(data: ""),
    MinIdQueryInput(data: 0),
    MaxIdQueryInput(data: 1000),
  ];

  void add(Product product);

  void remove(Product product);

  bool filter(Product product, QueryInput input) {
    switch (input) {
      case NameDescriptionQueryInput(data: String data):
        return product.name.contains(data) || product.description.contains(data);
      case MinIdQueryInput(data: int data):
        return product.idInt >= data;
      case MaxIdQueryInput(data: int data):
        return product.idInt <= data;
      case NoQueryInput():
        return true;
    }
  }
}
