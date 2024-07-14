import 'dart:typed_data';
import 'package:split_eth_flutter/vendor/web3/utils/uint8.dart';
import 'package:web3dart/web3dart.dart';
import 'package:flutter/services.dart' show rootBundle;

class SessionAccountContract {
  SessionAccountContract._(this._contract, this._client);

  final DeployedContract _contract;
  final Web3Client _client;

  Future<EthereumAddress> getOwner() async {
    final function = _contract.function('owner');

    final result = await _client.call(
      contract: _contract,
      function: function,
      params: [],
    );

    return result[0] as EthereumAddress;
  }

  Future<bool> hasValidSession(EthereumAddress sessionAddress) async {
    final function = _contract.function('hasValidSession');

    final result = await _client.call(
      contract: _contract,
      function: function,
      params: [sessionAddress],
    );

    return result[0] as bool;
  }

  Uint8List createAccountCallData(
    EthereumAddress provider,
    String salt,
  ) {
    final function = _contract.function('owner');

    return function.encodeCall([]);
  }

  Uint8List startSessionCallData(EthereumAddress provider, String salt, EthereumAddress sessionAddress,
      Uint8List providerSignature, Uint8List signature) {
    final function = _contract.function('startSession');

    print('startSessionCallData');

    return function.encodeCall([
      provider,
      convertStringToUint8List(salt),
      sessionAddress,
      providerSignature,
      signature,
    ]);
  }

  Uint8List executeCallData(String dest, BigInt amount, Uint8List calldata) {
    final function = _contract.function('execute');

    return function.encodeCall([EthereumAddress.fromHex(dest), amount, calldata]);
  }

  Uint8List executeBatchCallData(
    List<String> dest,
    List<Uint8List> calldata,
  ) {
    final function = _contract.function('executeBatch');

    return function.encodeCall([
      dest.map((d) => EthereumAddress.fromHex(d)).toList(),
      calldata,
    ]);
  }

  static Future<SessionAccountContract> init(String contractAddress, Web3Client client) async {
    final json = await rootBundle.loadString('lib/assets/session_account.abi.json');
    final abi = ContractAbi.fromJson(json, 'SessionAccount');
    final contract = DeployedContract(abi, EthereumAddress.fromHex(contractAddress));
    return SessionAccountContract._(contract, client);
  }
}
