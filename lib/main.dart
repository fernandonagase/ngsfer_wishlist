import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ngsfer_wishlist/data/repositories/sqflite_item_repository.dart';
import 'package:ngsfer_wishlist/data/services/sqflite_client.dart';
import 'package:provider/provider.dart';
import 'package:ngsfer_wishlist/ui/home/view_model/home_view_model.dart';
import 'package:ngsfer_wishlist/ui/home/widgets/home_screen.dart';
import 'package:ngsfer_wishlist/data/repositories/item_repository.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        Provider(create: (_) => SqfliteClient()),
        Provider(
          create: (context) =>
              SqfliteItemRepository(sqfliteClient: context.read())
                  as ItemRepository,
        ),
      ],
      child: const MainApp(),
    ),
  );
}

final _router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) =>
          HomeScreen(viewModel: HomeViewModel(itemRepository: context.read())),
    ),
  ],
);

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(routerConfig: _router);
  }
}
