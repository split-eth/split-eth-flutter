import 'dart:typed_data';
import 'package:split_eth_flutter/vendor/web3/utils/uint8.dart';
import 'package:web3dart/crypto.dart';
import 'package:web3dart/web3dart.dart';
import 'package:flutter/services.dart' show rootBundle;

class SessionAccountManagerContract {
  SessionAccountManagerContract._(this._contract, this._client, this._provider);

  final DeployedContract _contract;
  final Web3Client _client;
  final EthereumAddress _provider;

  Future<EthereumAddress> getAddress(
    String salt,
  ) async {
    final function = _contract.function('getAddress');

    final result = await _client.call(
      contract: _contract,
      function: function,
      params: [_provider, convertStringToBytes32(salt)],
    );

    return result[0] as EthereumAddress;
  }

  Uint8List createAccountCallData(
    String salt,
  ) {
    final function = _contract.function('createGroup');

    return function.encodeCall([_provider, convertStringToBytes32(salt)]);
  }

  Uint8List startSessionCallData(
      String salt, EthereumAddress sessionAddress, Uint8List providerSignature, Uint8List signature) {
    final function = _contract.function('startSession');

    return function.encodeCall([_provider, convertStringToBytes32(salt), sessionAddress, providerSignature, signature]);
  }

  Future<Uint8List> createAccountInitCode(
    String salt,
  ) async {
    final function = _contract.function('createAccount');

    final callData = function.encodeCall([_provider, convertStringToBytes32(salt)]);

    return hexToBytes('${_contract.address.hexEip55}${bytesToHex(callData)}');
  }

  static Future<SessionAccountManagerContract> init(
      String contractAddress, Web3Client client, EthereumAddress provider) async {
    final json = await rootBundle.loadString('lib/assets/session_account_manager.abi.json');
    final abi = ContractAbi.fromJson(json, 'SessionAccountManager');
    final contract = DeployedContract(abi, EthereumAddress.fromHex(contractAddress));
    return SessionAccountManagerContract._(contract, client, provider);
  }
}
