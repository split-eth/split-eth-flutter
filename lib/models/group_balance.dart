import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:split_eth_flutter/value_objects/ethereum_address_converter.dart';
import 'package:web3dart/web3dart.dart';

part 'group_balance.g.dart';

@JsonSerializable(
  converters: [EthereumAddressConverter()],
)
class GroupBalance extends Equatable {
  const GroupBalance({
    required this.address,
    required this.name,
    required this.balance,
  });

  final EthereumAddress address;
  final String name;
  final BigInt balance;

  @override
  List<Object?> get props => [address, name, balance];

  factory GroupBalance.fromJson(Map<String, dynamic> json) => _$GroupBalanceFromJson(json);
  Map<String, dynamic> toJson() => _$GroupBalanceToJson(this);
}
