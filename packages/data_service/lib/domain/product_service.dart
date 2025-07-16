import 'package:data_service/domain/product.dart';
import 'package:data_service/domain/query_input.dart';

abstract class ProductService {
  Future<List<Product>> getProducts(QueryInput input);

  Stream<List<Product>> get productStream;

  void add(Product product);

  void remove(Product product);

  bool filter(Product product, QueryInput input) {
    switch (input) {
      case NameDescriptionQueryInput(data: String data):
        return product.name.contains(data) || product.description.contains(data);
      case NoQueryInput():
        return true;
    }
  }
}
