import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:split_eth_flutter/value_objects/address.dart';
import 'package:split_eth_flutter/value_objects/group_entry_id.dart';

part 'group_entry.g.dart';

@JsonSerializable()
class GroupEntry extends Equatable {
  const GroupEntry({
    required this.id,
    required this.address,
    required this.amount,
    required this.note,
  });

  final GroupEntryId id;
  final Address address;
  final int amount;
  final String note;

  @override
  List<Object> get props => [id];

  factory GroupEntry.fromJson(Map<String, dynamic> json) => _$GroupEntryFromJson(json);
  Map<String, dynamic> toJson() => _$GroupEntryToJson(this);
}
