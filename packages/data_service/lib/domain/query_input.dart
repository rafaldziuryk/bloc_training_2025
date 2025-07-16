sealed class QueryInput {}

class NameDescriptionQueryInput extends QueryInput {
  NameDescriptionQueryInput({required this.data});

  final String data;
}

class MinIdQueryInput extends QueryInput {
  MinIdQueryInput({required this.data});

  final int data;
}

class MaxIdQueryInput extends QueryInput {
  MaxIdQueryInput({required this.data});

  final int data;
}

class NoQueryInput extends QueryInput {
  NoQueryInput();
}
