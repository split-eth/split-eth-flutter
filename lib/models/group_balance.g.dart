// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'group_balance.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GroupBalance _$GroupBalanceFromJson(Map<String, dynamic> json) => GroupBalance(
      address:
          const EthereumAddressConverter().fromJson(json['address'] as String),
      name: json['name'] as String,
      balance: BigInt.parse(json['balance'] as String),
    );

Map<String, dynamic> _$GroupBalanceToJson(GroupBalance instance) =>
    <String, dynamic>{
      'address': const EthereumAddressConverter().toJson(instance.address),
      'name': instance.name,
      'balance': instance.balance.toString(),
    };
