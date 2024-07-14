import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:split_eth_flutter/value_objects/ethereum_address_converter.dart';
import 'package:web3dart/web3dart.dart';

import '../value_objects/group_id.dart';
import 'group_entry.dart';

part 'group.g.dart';

@JsonSerializable(
  converters: [EthereumAddressConverter()],
)
class Group extends Equatable {
  const Group({
    required this.id,
    required this.name,
    required this.address,
    required this.entries,
  });

  final GroupId id;
  final String name;
  final EthereumAddress address;
  final List<GroupEntry> entries;

  @override
  List<Object> get props => [id];

  Group copyWith({
    GroupId? id,
    String? name,
    EthereumAddress? address,
    List<GroupEntry>? entries,
  }) {
    return Group(
      id: id ?? this.id,
      name: name ?? this.name,
      address: address ?? this.address,
      entries: entries ?? this.entries,
    );
  }

  factory Group.fromJson(Map<String, dynamic> json) => _$GroupFromJson(json);
  Map<String, dynamic> toJson() => _$GroupToJson(this);
}
