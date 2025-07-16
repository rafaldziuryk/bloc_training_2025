part of 'product_bloc.dart';


@immutable
sealed class ProductState extends Equatable {}

@immutable
final class ProductList extends ProductState {

  final List<String> products;

  ProductList({
    required this.products,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [products];
}

