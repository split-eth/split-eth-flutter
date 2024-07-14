import 'package:flutter/material.dart';
import 'package:split_eth_flutter/models/group_balance.dart';

class GroupBalanceItem extends StatelessWidget {
  const GroupBalanceItem({
    super.key,
    required this.balance,
  });

  final GroupBalance balance;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(balance.name),
      subtitle: Text(balance.balance.toString()),
    );
  }
}
