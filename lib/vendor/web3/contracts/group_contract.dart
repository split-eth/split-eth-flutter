import 'package:split_eth_flutter/models/group_entry.dart';
import 'package:split_eth_flutter/value_objects/group_entry_id.dart';
import 'package:split_eth_flutter/vendor/web3/service.dart';
import 'package:split_eth_flutter/vendor/web3/userop.dart';
import 'package:web3dart/web3dart.dart';
import 'package:flutter/services.dart' show rootBundle;

class GroupContract {
  GroupContract._(this._contract, this._client);

  final DeployedContract _contract;
  final Web3Client _client;

  Future<String> getName() async {
    final result = await _client.call(
      contract: _contract,
      function: _contract.function('name'),
      params: [],
    );

    return result[0] as String;
  }

  Future<List<GroupEntry>> getExpenses() async {
    final result = await _client.call(
      contract: _contract,
      function: _contract.function('getExpenses'),
      params: [],
    );

    final entries = result.map((data) {
      final EthereumAddress address = data[0][0] as EthereumAddress;
      return GroupEntry(
        id: GroupEntryId.random(),
        address: address,
        name: 'unknown',
        amount: data[0][1] as BigInt,
        note: data[0][2] as String,
      );
    }).toList();

    final usernames = await getUsernames(entries.map((entry) => entry.address).toList());

    return entries.map((entry) {
      return entry.copyWith(name: usernames[entry.address] ?? 'unknown');
    }).toList();
  }

  Future<Map<EthereumAddress, String>> getUsernames(List<EthereumAddress> addresses) async {
    return {for (var address in addresses) address: await getUsername(address)};
  }

  Future<String> getUsername(EthereumAddress userAddress) async {
    final result = await _client.call(
      contract: _contract,
      function: _contract.function('userNames'),
      params: [userAddress],
    );

    return result[0] as String;
  }

  static Future<GroupContract> init(EthereumAddress contractAddress) async {
    final json = await rootBundle.loadString('lib/assets/group.abi.json');
    final abi = ContractAbi.fromJson(json, 'Group');
    final contract = DeployedContract(abi, contractAddress);
    return GroupContract._(contract, Web3Service().ethClient);
  }
}
