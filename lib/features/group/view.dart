import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:split_eth_flutter/features/group/widgets/group_entry.dart';
import 'package:split_eth_flutter/models/group.dart';

class GroupView extends StatelessWidget {
  const GroupView({
    super.key,
    required this.group,
  });

  final Group group;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Group $group'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.go('/groups/new'), // TODO
        child: const Icon(Icons.add),
      ),
      body: ListView.builder(
        itemCount: 5, // TODO
        itemBuilder: (context, index) => const GroupEntry(),
      ),
    );
  }
}
