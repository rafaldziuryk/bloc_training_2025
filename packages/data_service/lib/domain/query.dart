import 'package:data_service/domain/product.dart';
import 'package:data_service/domain/query_input.dart';

sealed class Query {

}

class NameDescriptionQuery extends Query {}
