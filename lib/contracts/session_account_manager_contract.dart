import 'dart:typed_data';
import 'package:split_eth_flutter/vendor/web3/service.dart';
import 'package:split_eth_flutter/vendor/web3/utils/uint8.dart';
import 'package:web3dart/web3dart.dart';
import 'package:flutter/services.dart' show rootBundle;

class SessionAccountManagerContract {
  SessionAccountManagerContract._(this._contract);

  final DeployedContract _contract;

  Future<EthereumAddress> getAddress(
    EthereumAddress provider,
    EthereumAddress owner,
    String salt,
  ) async {
    final Uint8List calldata = _contract.function('getAddress').encodeCall([
      provider,
      owner,
      convertStringToUint8List(salt),
    ]);

    // TODO you go Kevin!!!!

    // final (_, userop) = await Web3Service().prepareUserop(
    //   [_contract.address.toString()],
    //   [calldata],
    // );

    // // TODO but I only need to read?????
    // final txHash = await Web3Service().submitUserop(userop);
    // TODO
    // web3service.prepareUserop
    // web3service.submitUserop
    throw UnimplementedError();
  }

  static Future<SessionAccountManagerContract> init(String contractAddress) async {
    final json = await rootBundle.loadString('lib/contracts/session_account_manager.abi.json');
    final abi = ContractAbi.fromJson(json, 'SessionAccountManager');
    final contract = DeployedContract(abi, EthereumAddress.fromHex(contractAddress));
    return SessionAccountManagerContract._(contract);
  }
}
