import 'package:flutter/material.dart';
import 'package:ngsfer_wishlist/domain/models/item.dart';

class ItemsList extends StatelessWidget {
  const ItemsList({super.key, required this.items, required this.onDelete});

  final List<Item> items;
  final void Function(Item item) onDelete;

  void _doDeleteItem(Item item, BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Confirmar exclusão'),
          content: const Text('Você tem certeza que deseja excluir este item?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                onDelete(item);
                Navigator.of(context).pop();
              },
              child: const Text('Excluir'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        for (final item in items)
          ListTile(
            title: Text(item.name),
            subtitle: item.price != null ? Text('R\$ ${item.price}') : null,
            trailing: IconButton(
              onPressed: () => _doDeleteItem(item, context),
              icon: const Icon(Icons.delete),
            ),
          ),
      ],
    );
  }
}
