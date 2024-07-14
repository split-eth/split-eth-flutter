import 'package:get_it/get_it.dart';
import 'package:split_eth_flutter/models/group.dart';
import 'package:split_eth_flutter/models/group_entry.dart';
import 'package:split_eth_flutter/value_objects/group_id.dart';
import 'package:split_eth_flutter/vendor/web3/config.dart';
import 'package:split_eth_flutter/vendor/web3/contracts/group_contract.dart';
import 'package:split_eth_flutter/vendor/web3/contracts/group_factory_contract.dart';
import 'package:web3dart/web3dart.dart';

class RemoteGroupRepo {
  final Config _config = GetIt.I.get<Config>();
  final GroupFactoryContract _groupFactoryContract = GetIt.I.get<GroupFactoryContract>();

  Future<Group> getRemoteGroup(GroupId groupId) async {
    EthereumAddress groupAddress = await _groupFactoryContract.getAddress(
      EthereumAddress.fromHex(_config.token.address),
      groupId.toString(),
    );

    final GroupContract groupContract = await GroupContract.init(groupAddress);

    late final String name;
    try {
      name = await groupContract.getName();
    } on RangeError {
      throw Exception('Group does not exist');
    }

    final List<GroupEntry> entries = await groupContract.getExpenses();

    return Group(
      id: groupId,
      name: name,
      address: groupAddress,
      entries: entries,
    );
  }
}
