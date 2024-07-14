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
      itemCount: balances.length,
      itemBuilder: (context, index) => GroupBalanceItem(balance: balances[index]),
    );
  }
}
