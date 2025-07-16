import 'package:data_service/domain/cart_service.dart';
import 'package:data_service/domain/product.dart';
import 'package:rxdart/rxdart.dart';

class CartServiceImpl extends CartService {
  final Map<Product, int> cartData = {};
  final BehaviorSubject<Map<Product, int>> _cartDataStream = BehaviorSubject.seeded({});

  @override
  Stream<Map<Product, int>> get cartStream => _cartDataStream.stream;

  @override
  void addItem(Product product) {
    cartData[product] = (cartData[product] ?? 0) + 1;
    final copy = Map.of(cartData);
    _cartDataStream.add(copy);
  }

  @override
  void removeItem(Product product) {
    if (cartData.containsKey(product)) {
      cartData[product] = (cartData[product] ?? 0) - 1;
      if (cartData[product] == 0) {
        cartData.remove(product);
      }
    }
    final copy = Map.of(cartData);
    _cartDataStream.add(copy);
  }
}
