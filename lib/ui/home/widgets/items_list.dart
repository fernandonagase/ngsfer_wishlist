import 'package:flutter/material.dart';

class ItemsList extends StatelessWidget {
  const ItemsList({super.key, required this.items});

  final List<String> items;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [for (final item in items) ListTile(title: Text(item))],
    );
  }
}
