import 'package:split_eth_flutter/vendor/web3/service.dart';
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

  static Future<GroupContract> init(EthereumAddress contractAddress) async {
    final json = await rootBundle.loadString('lib/assets/group.abi.json');
    final abi = ContractAbi.fromJson(json, 'Group');
    final contract = DeployedContract(abi, contractAddress);
    return GroupContract._(contract, Web3Service().ethClient);
  }
}
