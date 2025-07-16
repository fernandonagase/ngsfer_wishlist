import 'package:flutter/foundation.dart';
import 'package:ngsfer_wishlist/data/repositories/item_repository.dart';
import 'package:ngsfer_wishlist/domain/models/item.dart';
import 'package:ngsfer_wishlist/utils/money.dart';
import 'package:result_command/result_command.dart';
import 'package:result_dart/result_dart.dart';

typedef FormItem = ({String name, String? notes, String? price});

class NewItemViewModel extends ChangeNotifier {
  NewItemViewModel({required ItemRepository itemRepository, int? itemId})
    : _itemRepository = itemRepository,
      _itemId = itemId {
    addItemCommand = Command1(_addItem);
  }

  final ItemRepository _itemRepository;
  final int? _itemId;

  int? get itemId => _itemId;

  late Command1<void, FormItem> addItemCommand;

  Future<Result<Unit>> _addItem(FormItem formItem) async {
    try {
      final addItemResult = await _itemRepository.addItem(
        Item(
          name: formItem.name,
          notes: formItem.notes,
          price: formItem.price != null && formItem.price != ''
              ? Money.fromString(formItem.price!)
              : null,
        ),
      );
      return addItemResult.fold(
        (success) {
          return Success(unit);
        },
        (failure) {
          return Failure(failure);
        },
      );
    } on Exception catch (e) {
      return Failure(e);
    } finally {
      notifyListeners();
    }
  }
}
