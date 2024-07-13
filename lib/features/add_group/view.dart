import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:split_eth_flutter/features/add_group/controller.dart';

import '../../models/group.dart';

class AddGroupView extends StatelessWidget {
  const AddGroupView({super.key});

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      contentPadding: const EdgeInsets.all(24),
      children: [
        const Text('dialog'),
        TextButton(
            onPressed: () {
              final String id = List.generate(6, (_) => Random().nextInt(10)).join();
              final Group group = Group(id: id);
              context.read<AddGroupController>().addGroup(group);
            },
            child: const Text('add random'))
      ],
    );
  }
}
