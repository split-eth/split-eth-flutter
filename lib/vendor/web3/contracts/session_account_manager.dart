import 'dart:typed_data';
import 'package:split_eth_flutter/vendor/web3/utils/uint8.dart';
import 'package:web3dart/web3dart.dart';
import 'package:flutter/services.dart' show rootBundle;

class SessionAccountManagerContract {
  SessionAccountManagerContract._(this._contract, this._client);

  final DeployedContract _contract;
  final Web3Client _client;

  Future<EthereumAddress> getAddress(
    EthereumAddress provider,
    String salt,
  ) async {
    final function = _contract.function('getAddress');

    _client.call(
      contract: _contract,
      function: _contract.function('getAddress'),
      params: [provider, convertStringToUint8List(salt)],
    );

    final result = await _client.call(
      contract: _contract,
      function: function,
      params: [provider, convertStringToUint8List(salt)],
    );

    return result[0] as EthereumAddress;
  }

  Uint8List createAccountCallData(
    EthereumAddress provider,
    String salt,
  ) {
    final function = _contract.function('createGroup');

    return function.encodeCall([provider, convertStringToUint8List(salt)]);
  }

  Uint8List startSessionCallData(EthereumAddress provider, String salt, EthereumAddress sessionAddress,
      Uint8List providerSignature, Uint8List signature) {
    final function = _contract.function('createGroup');

    return function
        .encodeCall([provider, convertStringToUint8List(salt), sessionAddress, providerSignature, signature]);
  }

  static Future<SessionAccountManagerContract> init(String contractAddress, Web3Client client) async {
    final json = await rootBundle.loadString('lib/assets/session_account_manager.abi.json');
    final abi = ContractAbi.fromJson(json, 'SessionAccountManager');
    final contract = DeployedContract(abi, EthereumAddress.fromHex(contractAddress));
    return SessionAccountManagerContract._(contract, client);
  }
}
