import 'package:ngsfer_wishlist/utils/money.dart';

class Item {
  Item({this.id, required this.name, this.notes = '', this.price});

  int? id;
  String name;
  String? notes;
  Money? price;
}
