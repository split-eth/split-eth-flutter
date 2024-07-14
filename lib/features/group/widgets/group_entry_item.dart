import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:split_eth_flutter/features/group/controller.dart';
import 'package:split_eth_flutter/models/group_entry.dart';
import 'package:split_eth_flutter/vendor/web3/config.dart';
import 'package:split_eth_flutter/vendor/web3/utils.dart';

class GroupEntryItem extends StatelessWidget {
  GroupEntryItem({
    super.key,
    required this.groupEntry,
  });

  final GroupEntry groupEntry;

  final Config _config = GetIt.I.get<Config>();

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
          title: Text(groupEntry.note),
          subtitle: Text('paid by ${groupEntry.name} (${addressToShortString(groupEntry.address)}...)'),
          trailing: Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: groupEntry.formattedAmount,
                  style: const TextStyle(fontSize: 20),
                ),
                TextSpan(
                  text: ' ${_config.token.symbol}',
                  style: const TextStyle(fontSize: 12),
                ),
              ],
            ),
          )
      ),
    );
  }

  void _removeEntry(BuildContext context) {
    context.read<GroupController>().removeEntry(groupEntry);
  }
}
