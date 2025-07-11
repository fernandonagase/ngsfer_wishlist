import 'package:ngsfer_wishlist/utils/money.dart';
import 'package:result_dart/result_dart.dart';

typedef ApiItem = ({String name, String notes, Money price});
final List<ApiItem> items = [
  (name: 'Item 1', notes: '', price: Money(cents: 990)),
  (name: 'Item 2', notes: 'Item 2 com observacao', price: Money(cents: 1599)),
  (name: 'Item 3', notes: '', price: Money(cents: 4900)),
];

class MemoryClient {
  Future<Result<List<ApiItem>>> getItems() async {
    await Future.delayed(Duration(seconds: 2));
    return Success(items);
  }
}
