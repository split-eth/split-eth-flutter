// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'group.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Group _$GroupFromJson(Map<String, dynamic> json) => Group(
      id: GroupId.fromJson(json['id'] as String),
      name: json['name'] as String,
      address:
          const EthereumAddressConverter().fromJson(json['address'] as String),
      entries: (json['entries'] as List<dynamic>)
          .map((e) => GroupEntry.fromJson(e as Map<String, dynamic>))
          .toList(),
      balances: (json['balances'] as List<dynamic>)
          .map((e) => GroupBalance.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GroupToJson(Group instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'address': const EthereumAddressConverter().toJson(instance.address),
      'entries': instance.entries,
      'balances': instance.balances,
    };
