import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:split_eth_flutter/features/group_list/controller.dart';

import '../../../models/group.dart';

class GroupListItem extends StatelessWidget {
  const GroupListItem({super.key, required this.group});

  final Group group;

  @override
  Widget build(BuildContext context) {
    return Slidable(
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            onPressed: (context) {
              context.read<GroupListController>().removeLocalGroup(group);
            },
            label: 'Delete',
            backgroundColor: Colors.red,
            icon: Icons.delete,
          ),
        ],
      ),
      child: ListTile(
        title: Text('Group ${group.id}'),
        onTap: () => context.go('/groups/${group.id}'),
      ),
    );
  }
}
