import 'package:equatable/equatable.dart';
import 'package:split_eth_flutter/value_objects/address.dart';

class GroupEntry extends Equatable {
  const GroupEntry({
    required this.address,
    required this.amount,
    required this.note,
  });

  final Address address;
  final int amount;
  final String note;

  @override
  List<Object> get props => [address, amount, note];
}
