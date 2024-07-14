import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:split_eth_flutter/models/group_balance.dart';
import 'package:split_eth_flutter/vendor/web3/config.dart';
import 'package:split_eth_flutter/vendor/web3/utils.dart';

class GroupBalanceItem extends StatelessWidget {
  GroupBalanceItem({
    super.key,
    required this.balance,
  });

  final GroupBalance balance;

  final Config _config = GetIt.I.get<Config>();

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text.rich(TextSpan(
        children: [
          TextSpan(text: balance.name, style: const TextStyle(fontWeight: FontWeight.bold)),
          const TextSpan(text: ' will receive'),
        ],
      )),
      subtitle: Text('(${addressToShortString(balance.address)}...)'),
      trailing: Text.rich(
        TextSpan(
          children: [
            TextSpan(
              text: balance.formattedAmount,
              style: const TextStyle(fontSize: 20),
            ),
            TextSpan(
              text: ' ${_config.token.symbol}',
              style: const TextStyle(fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}
