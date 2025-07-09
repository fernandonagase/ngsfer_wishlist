import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ngsfer_wishlist/ui/home/view_model/home_view_model.dart';
import 'package:ngsfer_wishlist/ui/home/widgets/home_screen.dart';

void main() {
  runApp(const MainApp());
}

final _router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => HomeScreen(viewModel: HomeViewModel()),
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
