import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ngsfer_wishlist/ui/new_item/view_model/new_item_view_model.dart';

class NewItemScreen extends StatefulWidget {
  const NewItemScreen({super.key, required this.viewModel});

  final NewItemViewModel viewModel;

  @override
  State<NewItemScreen> createState() => _NewItemScreenState();
}

class _NewItemScreenState extends State<NewItemScreen> {
  final _formKey = GlobalKey<FormState>();

  final _descricaoController = TextEditingController();
  final _precoController = TextEditingController();
  final _observacoesController = TextEditingController();

  @override
  void dispose() {
    _descricaoController.dispose();
    _precoController.dispose();
    _observacoesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = widget.viewModel;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Adicionar item'),
        actions: <Widget>[
          TextButton(
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                await viewModel.addItemCommand.execute((
                  name: _descricaoController.text,
                  notes: _observacoesController.text,
                  price: _precoController.text,
                ));
                context.pop();
              }
            },
            child: const Text('Confirmar'),
          ),
        ],
      ),
      body: ListenableBuilder(
        listenable: widget.viewModel.addItemCommand,
        builder: (context, _) {
          return Column(
            children: [
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 200),
                child: widget.viewModel.addItemCommand.value.isRunning
                    ? const LinearProgressIndicator(key: ValueKey('progress'))
                    : const SizedBox(key: ValueKey('empty'), height: 4),
              ),
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      spacing: 12.0,
                      children: [
                        Row(
                          spacing: 12.0,
                          children: [
                            Expanded(
                              flex: 4,
                              child: TextFormField(
                                controller: _descricaoController,
                                textInputAction: TextInputAction.next,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Descrição*',
                                  helperText: '',
                                ),
                                autofocus: true,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Campo obrigatório.';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: TextFormField(
                                controller: _precoController,
                                textInputAction: TextInputAction.next,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Preço',
                                  prefixText: 'R\$ ',
                                  helperText: '',
                                ),
                                keyboardType: TextInputType.number,
                              ),
                            ),
                          ],
                        ),
                        TextFormField(
                          controller: _observacoesController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Observações',
                            alignLabelWithHint: true,
                          ),
                          keyboardType: TextInputType.multiline,
                          minLines: 3,
                          maxLines: null,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
