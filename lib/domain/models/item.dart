import 'package:ngsfer_wishlist/utils/money.dart';

class Item {
  Item({required this.name, required this.price, this.notes = ''});

  String name;
  String notes;
  Money price;
}
