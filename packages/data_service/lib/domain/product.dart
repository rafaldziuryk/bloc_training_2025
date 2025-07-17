import 'package:equatable/equatable.dart';

class Product extends Equatable{
  final String name;
  final String id;
  final String description;

  const Product({
    required this.name,
    required this.id,
    required this.description,
  });

  @override
  String toString() {
    return 'Product(name: $name, id: $id, description: $description)';
  }

  // @override
  // bool operator ==(Object other) {
  //   if (identical(this, other)) return true;
  //   return other is Product &&
  //       other.name == name &&
  //       other.id == id &&
  //       other.description == description;
  // }

  @override
  int get hashCode => Object.hash(name, id, description);

  @override
  List<Object?> get props => [name, id, description];
}
