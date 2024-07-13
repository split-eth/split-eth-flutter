import 'dart:typed_data';
import 'package:split_eth_flutter/vendor/web3/utils/uint8.dart';
import 'package:web3dart/web3dart.dart';
import 'package:flutter/services.dart' show rootBundle;

class GroupFactoryContract {
  GroupFactoryContract._(this._contract, this._client);

  final DeployedContract _contract;
  final Web3Client _client;

  Future<EthereumAddress> getAddress(
    EthereumAddress token,
    String salt,
  ) async {
    final function = _contract.function('getAddress');

    _client.call(
      contract: _contract,
      function: _contract.function('getAddress'),
      params: [token, convertStringToUint8List(salt)],
    );

    final result = await _client.call(
      contract: _contract,
      function: function,
      params: [token, convertStringToUint8List(salt)],
    );

    return result[0] as EthereumAddress;
  }

  Uint8List createGroupCallData(
    EthereumAddress owner,
    EthereumAddress token,
    String salt,
    String name,
  ) {
    final function = _contract.function('createGroup');

    return function.encodeCall([owner, token, convertStringToUint8List(salt), name]);
  }

  static Future<GroupFactoryContract> init(String contractAddress, Web3Client client) async {
    final json = await rootBundle.loadString('lib/assets/group_factory.abi.json');
    final abi = ContractAbi.fromJson(json, 'GroupFactory');
    final contract = DeployedContract(abi, EthereumAddress.fromHex(contractAddress));
    return GroupFactoryContract._(contract, client);
  }
}
