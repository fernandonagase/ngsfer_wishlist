class ItemDto {
  ItemDto({this.id, required this.name, this.notes, this.price});
  ItemDto.fromMap(Map<String, Object?> map)
    : id = map['id'] as int,
      name = map['name'] as String,
      notes = map['notes'] as String?,
      price = map['price'] as int?;

  final int? id;
  final String name;
  final String? notes;
  final int? price;

  Map<String, Object?> toMap() {
    var map = <String, Object?>{'name': name, 'notes': notes, 'price': price};
    if (id != null) {
      map['id'] = id;
    }
    return map;
  }
}
