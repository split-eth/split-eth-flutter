import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:split_eth_flutter/value_objects/ethereum_address_converter.dart';
import 'package:split_eth_flutter/value_objects/group_entry_id.dart';
import 'package:split_eth_flutter/vendor/web3/config.dart';
import 'package:split_eth_flutter/vendor/web3/utils.dart';
import 'package:web3dart/web3dart.dart';

part 'group_entry.g.dart';

@JsonSerializable(
  converters: [EthereumAddressConverter()],
)
class GroupEntry extends Equatable {
  const GroupEntry({
    required this.id,
    required this.address,
    required this.name,
    required this.amount,
    required this.note,
  });

  final GroupEntryId id;
  final EthereumAddress address;
  final String name;
  final BigInt amount;
  final String note;

  GroupEntry copyWith({
    GroupEntryId? id,
    EthereumAddress? address,
    String? name,
    BigInt? amount,
    String? note,
  }) {
    return GroupEntry(
      id: id ?? this.id,
      address: address ?? this.address,
      name: name ?? this.name,
      amount: amount ?? this.amount,
      note: note ?? this.note,
    );
  }

  String get formattedAmount => formatNumber(amount, GetIt.I.get<Config>().token.decimals, 2);

  @override
  List<Object> get props => [id];

  factory GroupEntry.fromJson(Map<String, dynamic> json) => _$GroupEntryFromJson(json);
  Map<String, dynamic> toJson() => _$GroupEntryToJson(this);
}
