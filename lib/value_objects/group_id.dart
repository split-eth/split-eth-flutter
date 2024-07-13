import 'package:equatable/equatable.dart';

class GroupId extends Equatable {
  GroupId(String groupId) {
    // TODO validation
    _groupId = groupId;
  }

  late final String _groupId;

  @override
  String toString() {
    return _groupId;
  }

  @override
  List<Object> get props => [_groupId];

  factory GroupId.fromJson(String groupId) => GroupId(groupId);
  String toJson() => _groupId;
}
