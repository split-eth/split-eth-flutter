import 'package:equatable/equatable.dart';

class Address extends Equatable {
  Address(String address) {
    // TODO validation
    _address = address;
  }

  late final String _address;

  @override
  String toString() {
    return _address;
  }

  @override
  List<Object> get props => [_address];

  factory Address.fromJson(String address) => Address(address);
  String toJson() => _address;
}
