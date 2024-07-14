import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:split_eth_flutter/features/group/controller.dart';
import 'package:split_eth_flutter/features/group/widgets/group_balance_item.dart';

class GroupSummary extends StatelessWidget {
  const GroupSummary({super.key});

  @override
  Widget build(BuildContext context) {
    final isFunded = context.select((GroupController c) => c.group.isFunded);
    final balances = context.select((GroupController c) => c.group.balances);

    return ListView.builder(
      itemCount: balances.length + 1,
      itemBuilder: (context, index) {
        if (index == balances.length) {
          return Center(
            child: ElevatedButton(
              onPressed: isFunded ? () => _handleSplit(context) : null,
              child: const Text('Split'),
            ),
          );
        }

        return GroupBalanceItem(balance: balances[index]);
      },
    );
  }

  void _handleSplit(BuildContext context) async {
    showDialog(
      context: context,
      builder: (_) => const Center(child: CircularProgressIndicator()),
    );

    try {
      await context.read<GroupController>().split();
    } catch (e) {
      if (context.mounted) {
        await showDialog(
          context: context,
          builder: (_) => Center(
            child: Text(
              e.toString(),
              style: const TextStyle(color: Colors.red),
            ),
          ),
        );
      }
    } finally {
      if (context.mounted) {
        Navigator.of(context).pop();
      }
    }
  }
}
