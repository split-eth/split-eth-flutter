import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'group_entry.dart';

part 'group.g.dart';

@JsonSerializable()
class Group extends Equatable {
  const Group({
    required this.id,
    required this.entries,
  });

  final String id;
  final List<GroupEntry> entries;

  @override
  List<Object> get props => [id];

  factory Group.fromJson(Map<String, dynamic> json) => _$GroupFromJson(json);
  Map<String, dynamic> toJson() => _$GroupToJson(this);
}
