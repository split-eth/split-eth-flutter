import 'package:json_annotation/json_annotation.dart';
import 'package:web3dart/web3dart.dart';

class EthereumAddressConverter implements JsonConverter<EthereumAddress, String> {
  const EthereumAddressConverter();

  @override
  EthereumAddress fromJson(String json) {
    return EthereumAddress.fromHex(json);
  }

  @override
  String toJson(EthereumAddress object) {
    return object.toString();
  }
}
