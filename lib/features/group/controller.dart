import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:split_eth_flutter/features/group/view.dart';
import 'package:split_eth_flutter/models/group.dart';
import 'package:split_eth_flutter/repos/local_group_repo.dart';

class GroupController extends ChangeNotifier {
  GroupController._(Group group) : _group = group;

  final Group _group;

  Widget createView() {
    return ChangeNotifierProvider.value(
      value: this,
      child: GroupView(group: _group),
    );
  }

  static final Map<String, GroupController> _instances = {};
  static GroupController of(String groupId) {
    final Group group = GetIt.I<LocalGroupRepo>().getGroupById(groupId);
    return _instances.putIfAbsent(groupId, () => GroupController._(group));
  }
}
