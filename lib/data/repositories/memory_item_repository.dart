import 'package:ngsfer_wishlist/data/repositories/item_repository.dart';
import 'package:ngsfer_wishlist/data/services/memory_client.dart';
import 'package:ngsfer_wishlist/domain/models/item.dart';
import 'package:result_dart/result_dart.dart';

class MemoryItemRepository implements ItemRepository {
  MemoryItemRepository({required MemoryClient memoryClient})
    : _memoryClient = memoryClient;

  final MemoryClient _memoryClient;

  @override
  Future<Result<List<Item>>> getItems() async {
    final apiItemsResult = await _memoryClient.getItems();
    return apiItemsResult.fold(
      (success) => Success(
        success
            .map(
              (apiItem) => Item(
                id: apiItem.id,
                name: apiItem.name,
                notes: apiItem.notes,
                price: apiItem.price,
              ),
            )
            .toList(),
      ),
      (failure) => Failure(failure),
    );
  }

  @override
  Future<Result<Unit>> addItem(Item item) {
    // TODO: implement addItem
    throw UnimplementedError();
  }

  @override
  Future<Result<Unit>> deleteItem(Item item) {
    // TODO: implement deleteItem
    throw UnimplementedError();
  }

  @override
  Future<Result<Item>> getItemById(int id) {
    // TODO: implement getItemById
    throw UnimplementedError();
  }
}
