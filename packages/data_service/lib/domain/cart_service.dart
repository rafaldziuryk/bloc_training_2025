import 'package:data_service/domain/product.dart';

abstract class CartService {
  Stream<Map<Product, int>> get cartStream;

  void addItem(Product product);

  void removeItem(Product product);
}
