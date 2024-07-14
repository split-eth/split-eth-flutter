import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:split_eth_flutter/value_objects/ethereum_address_converter.dart';
import 'package:split_eth_flutter/vendor/web3/config.dart';
import 'package:split_eth_flutter/vendor/web3/utils.dart';
import 'package:web3dart/web3dart.dart';

part 'group_balance.g.dart';

@JsonSerializable(
  converters: [EthereumAddressConverter()],
)
class GroupBalance extends Equatable {
  const GroupBalance({
    required this.address,
    required this.name,
    required this.amount,
  });

  final EthereumAddress address;
  final String name;
  final BigInt amount;

  String get formattedAmount => formatNumber(amount, GetIt.I.get<Config>().token.decimals, 2);

  @override
  List<Object?> get props => [address, name, amount];

  factory GroupBalance.fromJson(Map<String, dynamic> json) => _$GroupBalanceFromJson(json);
  Map<String, dynamic> toJson() => _$GroupBalanceToJson(this);
}
