// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'group_entry.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GroupEntry _$GroupEntryFromJson(Map<String, dynamic> json) => GroupEntry(
      id: GroupEntryId.fromJson(json['id'] as String),
      address:
          const EthereumAddressConverter().fromJson(json['address'] as String),
      amount: (json['amount'] as num).toInt(),
      note: json['note'] as String,
    );

Map<String, dynamic> _$GroupEntryToJson(GroupEntry instance) =>
    <String, dynamic>{
      'id': instance.id,
      'address': const EthereumAddressConverter().toJson(instance.address),
      'amount': instance.amount,
      'note': instance.note,
    };
