import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:split_eth_flutter/features/group/controller.dart';
import 'package:split_eth_flutter/features/group/widgets/group_balance_item.dart';

class GroupSummary extends StatelessWidget {
  const GroupSummary({super.key});

  @override
  Widget build(BuildContext context) {
    final balances = context.select((GroupController c) => c.group.balances);
    return ListView.builder(
      itemCount: balances.length + 1,
      itemBuilder: (context, index) {
        if (index == balances.length) {
          return Center(
            child: ElevatedButton(
              onPressed: () {
                // TODO
              },
              child: const Text('Split'),
            ),
          );
        }

        return GroupBalanceItem(balance: balances[index]);
      },
    );
  }
}
