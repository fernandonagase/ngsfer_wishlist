import 'package:ngsfer_wishlist/domain/models/item.dart';
import 'package:result_dart/result_dart.dart';

abstract class ItemRepository {
  Future<Result<List<Item>>> getItems();
  Future<Result<Item>> getItemById(int id);
  Future<Result<Unit>> addItem(Item item);
  Future<Result<Unit>> deleteItem(Item item);
}
