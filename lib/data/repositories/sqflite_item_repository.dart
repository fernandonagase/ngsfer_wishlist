import 'package:ngsfer_wishlist/data/dtos/item_dto.dart';
import 'package:ngsfer_wishlist/data/repositories/item_repository.dart';
import 'package:ngsfer_wishlist/data/services/sqflite_client.dart';
import 'package:ngsfer_wishlist/domain/models/item.dart';
import 'package:ngsfer_wishlist/utils/money.dart';
import 'package:result_dart/result_dart.dart';

class SqfliteItemRepository implements ItemRepository {
  SqfliteItemRepository({required SqfliteClient sqfliteClient})
    : _sqfliteClient = sqfliteClient;

  final SqfliteClient _sqfliteClient;

  @override
  Future<Result<List<Item>>> getItems() async {
    final apiItemsResult = await _sqfliteClient.getItems();
    return apiItemsResult.fold(
      (success) => Success(
        success
            .map(
              (apiItem) => Item(
                id: apiItem.id,
                name: apiItem.name,
                notes: apiItem.notes,
                price: apiItem.price != null
                    ? Money(cents: apiItem.price!)
                    : null,
              ),
            )
            .toList(),
      ),
      (failure) => Failure(failure),
    );
  }

  @override
  Future<Result<Unit>> addItem(Item item) async {
    final addItemResult = await _sqfliteClient.addItem(
      ItemDto(name: item.name, notes: item.notes, price: item.price?.cents),
    );
    return addItemResult.fold(
      (success) => Success(unit),
      (failure) => Failure(failure),
    );
  }

  @override
  Future<Result<Unit>> deleteItem(Item item) async {
    if (item.id == null) throw ArgumentError('item.id não pode ser nulo.');
    final deleteItemResult = await _sqfliteClient.deleteItem(item.id!);
    return deleteItemResult.fold(
      (success) => Success(unit),
      (failure) => Failure(failure),
    );
  }
}
