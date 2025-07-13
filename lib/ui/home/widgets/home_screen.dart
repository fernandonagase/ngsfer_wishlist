import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ngsfer_wishlist/ui/home/view_model/home_view_model.dart';
import 'package:ngsfer_wishlist/ui/home/widgets/items_list.dart';
import 'package:result_command/result_command.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key, required this.viewModel});

  final HomeViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Minha lista')),
      body: ListenableBuilder(
        listenable: viewModel.loadCommand,
        builder: (context, _) {
          return switch (viewModel.loadCommand.value) {
            RunningCommand() => Center(child: CircularProgressIndicator()),
            SuccessCommand() => ListenableBuilder(
              listenable: viewModel,
              builder: (context, _) => ItemsList(
                items: viewModel.items,
                onDelete: (item) {
                  viewModel.deleteItemCommand.execute(item);
                },
              ),
            ),
            FailureCommand(:final error) => Text('Failure: $error'),
            _ => Center(
              child: Text(viewModel.loadCommand.value.runtimeType.toString()),
            ),
          };
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.goNamed('novo-item');
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
