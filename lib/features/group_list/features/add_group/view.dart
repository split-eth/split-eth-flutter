import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:split_eth_flutter/atoms/seth_text_field.dart';
import 'package:split_eth_flutter/features/group_list/controller.dart';
import 'package:split_eth_flutter/atoms/labeled_divider.dart';
import 'package:split_eth_flutter/value_objects/group_id.dart';

import '../../../../models/group.dart';

class AddGroupView extends StatelessWidget {
  const AddGroupView({super.key});

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      contentPadding: const EdgeInsets.all(24),
      children: [
        SethTextField(
          label: 'Enter Group ID',
          // NOTE: needed to show "done" button on iOS
          keyboardType: const TextInputType.numberWithOptions(signed: true),
          onFieldSubmitted: (String value) => _joinGroup(context, GroupId(value)),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: LabeledDivider(label: 'or'),
        ),
        ElevatedButton.icon(
          icon: const Icon(Icons.add),
          label: const Text('Create Group'),
          onPressed: () => _joinGroup(context, GroupId.random()),
        ),
      ],
    );
  }

  void _joinGroup(BuildContext context, GroupId id) {
    final Group group = Group(id: id, entries: const []);
    context.read<GroupListController>().addGroup(group);
    context.go('/groups/$id'); // TODO go to share page?
  }
}
