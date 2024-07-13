import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:split_eth_flutter/features/group/view.dart';
import 'package:split_eth_flutter/models/group.dart';
import 'package:split_eth_flutter/repos/local_group_repo.dart';

import '../../value_objects/group_id.dart';

class GroupController extends ChangeNotifier {
  GroupController._(GroupId groupId) : _groupId = groupId;

  final GroupId _groupId;

  Group get group => GetIt.I<LocalGroupRepo>().getGroupById(_groupId);

  Widget createView() {
    return ChangeNotifierProvider.value(
      value: this,
      child: const GroupView(),
    );
  }

  static final Map<GroupId, GroupController> _instances = {};
  static GroupController of(GroupId groupId) {
    return _instances.putIfAbsent(groupId, () => GroupController._(groupId));
  }
}
