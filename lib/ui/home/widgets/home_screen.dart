import 'package:flutter/material.dart';
import 'package:ngsfer_wishlist/ui/home/view_model/home_view_model.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key, required this.viewModel});

  final HomeViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text(viewModel.test)));
  }
}
