import 'package:ngsfer_wishlist/domain/models/item.dart';
import 'package:result_dart/result_dart.dart';

abstract class ItemRepository {
  Future<Result<List<Item>>> getItems();
}
