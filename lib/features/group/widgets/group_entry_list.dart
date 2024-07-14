import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:split_eth_flutter/features/group/controller.dart';
import 'package:split_eth_flutter/features/group/widgets/group_entry_item.dart';

class GroupEntryList extends StatelessWidget {
  const GroupEntryList({super.key});

  @override
  Widget build(BuildContext context) {
    final entries = context.select((GroupController c) => c.group.entries);
    return ListView.builder(
      itemCount: entries.length,
      itemBuilder: (context, index) => GroupEntryItem(groupEntry: entries[index]),
    );
  }
}
