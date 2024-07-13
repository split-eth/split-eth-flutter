import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

class GroupEntryId extends Equatable {
  const GroupEntryId(String groupEntryId) : _groupEntryId = groupEntryId;

  factory GroupEntryId.random() {
    final String id = (const Uuid()).v4();
    return GroupEntryId(id);
  }

  final String _groupEntryId;

  @override
  String toString() {
    return _groupEntryId;
  }

  @override
  List<Object> get props => [_groupEntryId];

  factory GroupEntryId.fromJson(String groupId) => GroupEntryId(groupId);
  String toJson() => _groupEntryId;
}
