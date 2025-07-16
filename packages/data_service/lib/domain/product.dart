class Product {
  final String name;
  final String id;
  final String description;

  const Product({
    required this.name,
    required this.id,
    required this.description,
  });

  int get idInt => int.parse(id.substring(4));

  @override
  String toString() {
    return 'Product(name: $name, id: $id, description: $description)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Product &&
        other.name == name &&
        other.id == id &&
        other.description == description;
  }

  @override
  int get hashCode => Object.hash(name, id, description);
}
