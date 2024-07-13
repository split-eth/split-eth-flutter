import 'dart:math';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:split_eth_flutter/atoms/seth_text_field.dart';
import 'package:split_eth_flutter/features/group_list/controller.dart';
import 'package:split_eth_flutter/atoms/labeled_divider.dart';

import '../../../../models/group.dart';

class AddGroupView extends StatelessWidget {
  const AddGroupView({super.key});

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      contentPadding: const EdgeInsets.all(24),
      children: [
        const SethTextField(
          label: 'Group ID',
          keyboardType: TextInputType.number,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: LabeledDivider(label: 'or'),
        ),
        ElevatedButton.icon(
          onPressed: () => _createGroup(context),
          icon: const Icon(Icons.add),
          label: const Text('Create Group'),
        ),
      ],
    );
  }

  static void _createGroup(BuildContext context) {
    final String id = List.generate(6, (_) => Random().nextInt(10)).join();
    final Group group = Group(id: id);
    context.read<GroupListController>().addGroup(group);
    context.go('/groups/$id'); // TODO go to share page?
  }
}
