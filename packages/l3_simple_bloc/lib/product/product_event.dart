part of 'product_bloc.dart';

@immutable
sealed class ProductEvent extends Equatable {
  const ProductEvent();

  @override
  List<Object?> get props => throw UnimplementedError();
}




final class ProductAdd extends ProductEvent  {
  final String product;
  const ProductAdd({ required this.product});
}


final class ProductDelete extends ProductEvent {
  final String product;
  const ProductDelete({required this.product});
}
 