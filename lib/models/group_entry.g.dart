// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'group_entry.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GroupEntry _$GroupEntryFromJson(Map<String, dynamic> json) => GroupEntry(
      id: GroupEntryId.fromJson(json['id'] as String),
      address:
          const EthereumAddressConverter().fromJson(json['address'] as String),
      name: json['name'] as String,
      amount: BigInt.parse(json['amount'] as String),
      note: json['note'] as String,
    );

Map<String, dynamic> _$GroupEntryToJson(GroupEntry instance) =>
    <String, dynamic>{
      'id': instance.id,
      'address': const EthereumAddressConverter().toJson(instance.address),
      'name': instance.name,
      'amount': instance.amount.toString(),
      'note': instance.note,
    };
