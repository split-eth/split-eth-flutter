import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:split_eth_flutter/atoms/seth_text_field.dart';
import 'package:split_eth_flutter/features/group/controller.dart';
import 'package:split_eth_flutter/features/group_list/controller.dart';
import 'package:split_eth_flutter/models/group_entry.dart';
import 'package:split_eth_flutter/value_objects/group_entry_id.dart';
import 'package:web3dart/web3dart.dart';

class AddGroupEntryView extends StatefulWidget {
  const AddGroupEntryView({super.key});

  static const Widget _spacer = SizedBox(height: 10);

  @override
  State<AddGroupEntryView> createState() => _AddGroupEntryViewState();
}

class _AddGroupEntryViewState extends State<AddGroupEntryView> {
  final TextEditingController _valueController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();

  @override
  void initState() {
    super.initState();

    // post frame callback
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // initial requests go here

      onLoad();
    });
  }

  void onLoad() async {
    await context.read<GroupController>().loadAccount();
  }

  @override
  void dispose() {
    _valueController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      contentPadding: const EdgeInsets.all(24),
      children: [
        const Center(child: Text('TODO YOUR ADDRESS')),
        AddGroupEntryView._spacer,
        SethTextField(
          controller: _valueController,
          label: 'Value',
          keyboardType: TextInputType.number,
        ),
        AddGroupEntryView._spacer,
        SethTextField(
          controller: _noteController,
          label: 'Note',
        ),
        AddGroupEntryView._spacer,
        ElevatedButton.icon(
          icon: const Icon(Icons.add),
          label: const Text('Add Entry'),
          onPressed: _addEntry,
        )
      ],
    );
  }

  void _addEntry() async {
    context.read<GroupController>().addEntry(BigInt.parse(_valueController.text), _noteController.text);

    context.pop();
  }
}
