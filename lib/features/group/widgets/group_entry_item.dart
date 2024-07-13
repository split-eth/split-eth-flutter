import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:split_eth_flutter/features/group/controller.dart';
import 'package:split_eth_flutter/models/group_entry.dart';

class GroupEntryItem extends StatelessWidget {
  const GroupEntryItem({
    super.key,
    required this.groupEntry,
  });

  final GroupEntry groupEntry;

  @override
  Widget build(BuildContext context) {
    return Slidable(
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            onPressed: _removeEntry,
            label: 'Delete',
            backgroundColor: Colors.red,
            icon: Icons.delete,
          ),
        ],
      ),
      child: ListTile(
        title: Text('${groupEntry.address}: ${groupEntry.note} (${groupEntry.amount})'),
      ),
    );
  }

  void _removeEntry(BuildContext context) {
    context.read<GroupController>().removeEntry(groupEntry);
  }
}
