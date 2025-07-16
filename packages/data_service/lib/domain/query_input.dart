sealed class QueryInput {}

class NameDescriptionQueryInput extends QueryInput {
  NameDescriptionQueryInput({required this.data});

  final String data;
}

class NoQueryInput extends QueryInput {
  NoQueryInput();
}
