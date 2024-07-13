import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:split_eth_flutter/features/group/controller.dart';
import 'package:split_eth_flutter/features/group/widgets/group_entry_item.dart';

class GroupView extends StatelessWidget {
  const GroupView({super.key});

  @override
  Widget build(BuildContext context) {
    final id = context.select((GroupController c) => c.group.id);
    final entries = context.select((GroupController c) => c.group.entries);
    
    return Scaffold(
      appBar: AppBar(
        title: Text('Group $id'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.go('/groups/$id/add_entry'),
        child: const Icon(Icons.add),
      ),
      body: ListView.builder(
        itemCount: entries.length,
        itemBuilder: (context, index) => GroupEntryItem(groupEntry: entries[index]),
      ),
    );
  }
}
