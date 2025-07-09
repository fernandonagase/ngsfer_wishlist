import 'package:flutter/foundation.dart';
import 'package:ngsfer_wishlist/data/repositories/item_repository.dart';
import 'package:result_command/result_command.dart';
import 'package:result_dart/result_dart.dart';

class HomeViewModel extends ChangeNotifier {
  HomeViewModel({required ItemRepository itemRepository})
    : _itemRepository = itemRepository {
    loadCommand = Command0(_load)..execute();
  }

  final ItemRepository _itemRepository;
  List<String> _items = [];
  final test = 'Hello World! ViewModel';

  late Command0 loadCommand;

  List<String> get items => _items;

  Future<Result<Unit>> _load() async {
    try {
      final loadResult = await _itemRepository.getItems();
      return loadResult.fold(
        (success) {
          _items = success;
          return Success(unit);
        },
        (failure) {
          return Failure(failure);
        },
      );
    } finally {
      notifyListeners();
    }
  }
}
