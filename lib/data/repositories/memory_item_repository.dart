import 'package:ngsfer_wishlist/data/repositories/item_repository.dart';
import 'package:ngsfer_wishlist/data/services/memory_client.dart';
import 'package:result_dart/result_dart.dart';

class MemoryItemRepository implements ItemRepository {
  MemoryItemRepository({required MemoryClient memoryClient})
    : _memoryClient = memoryClient;

  final MemoryClient _memoryClient;

  @override
  Future<Result<List<String>>> getItems() {
    return _memoryClient.getItems();
  }
}
