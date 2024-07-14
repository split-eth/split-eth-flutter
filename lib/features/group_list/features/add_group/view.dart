import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:split_eth_flutter/atoms/seth_text_field.dart';
import 'package:split_eth_flutter/features/group_list/controller.dart';
import 'package:split_eth_flutter/atoms/labeled_divider.dart';
import 'package:split_eth_flutter/value_objects/group_id.dart';
import 'package:split_eth_flutter/vendor/web3/userop.dart';
import 'package:web3dart/web3dart.dart';

import '../../../../models/group.dart';

class AddGroupView extends StatelessWidget {
  const AddGroupView({super.key});

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      contentPadding: const EdgeInsets.all(24),
      children: [
        SethTextField(
          label: 'Enter Group ID',
          // NOTE: needed to show "done" button on iOS
          keyboardType: const TextInputType.numberWithOptions(signed: true),
          onFieldSubmitted: (String value) {
            context.pop();
            context.go('/groups/joining?id=$value');
          },
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: LabeledDivider(label: 'or'),
        ),
        ElevatedButton.icon(
          icon: const Icon(Icons.add),
          label: const Text('Create Group'),
          onPressed: () async {
            // TODO deploy group contract
            final Group group = Group(
              id: GroupId.random(),
              name: 'TODO', // TODO
              address: EthereumAddress.fromHex(zeroAddress), // TODO
              entries: const [],
              balances: const [],
            );
            context.read<GroupListController>().addLocalGroup(group);
            context.pop();
          },
        ),
      ],
    );
  }
}
