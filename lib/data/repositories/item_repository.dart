import 'package:result_dart/result_dart.dart';

abstract class ItemRepository {
  Future<Result<List<String>>> getItems();
}
