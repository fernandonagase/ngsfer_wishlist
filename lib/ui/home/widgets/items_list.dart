import 'package:flutter/material.dart';
import 'package:ngsfer_wishlist/domain/models/item.dart';

class ItemsList extends StatelessWidget {
  const ItemsList({super.key, required this.items});

  final List<Item> items;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        for (final item in items)
          ListTile(
            title: Text(item.name),
            subtitle: item.price != null ? Text('R\$ ${item.price}') : null,
          ),
      ],
    );
  }
}
