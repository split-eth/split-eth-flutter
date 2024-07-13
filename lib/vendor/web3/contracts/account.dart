import 'dart:async';
import 'dart:typed_data';
import 'package:flutter/services.dart' show rootBundle;

import 'package:web3dart/web3dart.dart';

class AccountContract {
  final int chainId;
  final Web3Client client;
  final String addr;
  late DeployedContract rcontract;

  AccountContract(this.chainId, this.client, this.addr);

  Future<void> init() async {
    final rawAbi = await rootBundle.loadString('packages/smartcontracts/contracts/accounts/Account.abi.json');

    final cabi = ContractAbi.fromJson(rawAbi, 'Account');

    rcontract = DeployedContract(cabi, EthereumAddress.fromHex(addr));
  }

  // Future<EthereumAddress> tokenEntryPoint() async {
  //   return contract.tokenEntryPoint();
  // }

  // Future<EthereumAddress> owner() async {
  //   return contract.owner();
  // }

  Uint8List executeCallData(String dest, BigInt amount, Uint8List calldata) {
    final function = rcontract.function('execute');

    return function.encodeCall([EthereumAddress.fromHex(dest), amount, calldata]);
  }

  Uint8List executeBatchCallData(
    List<String> dest,
    List<Uint8List> calldata,
  ) {
    final function = rcontract.function('executeBatch');

    return function.encodeCall([
      dest.map((d) => EthereumAddress.fromHex(d)).toList(),
      calldata,
    ]);
  }

  Uint8List transferOwnershipCallData(String newOwner) {
    final function = rcontract.function('transferOwnership');

    return function.encodeCall([EthereumAddress.fromHex(newOwner)]);
  }

  Uint8List upgradeToCallData(String implementation) {
    final function = rcontract.function('upgradeTo');

    return function.encodeCall([EthereumAddress.fromHex(implementation)]);
  }
}
