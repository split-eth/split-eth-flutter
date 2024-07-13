import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:split_eth_flutter/features/group/controller.dart';
import 'package:split_eth_flutter/features/group/widgets/group_entry.dart';

class GroupView extends StatelessWidget {
  const GroupView({super.key});

  @override
  Widget build(BuildContext context) {
    final group = context.select((GroupController c) => c.group);
    
    return Scaffold(
      appBar: AppBar(
        title: Text('Group ${group.id}'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.go('/groups/${group.id}/add_entry'),
        child: const Icon(Icons.add),
      ),
      body: ListView.builder(
        itemCount: group.entries.length,
        itemBuilder: (context, index) => const GroupEntry(), // TODO
      ),
    );
  }
}
