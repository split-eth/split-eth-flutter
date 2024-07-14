import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:split_eth_flutter/models/group.dart';
import 'package:split_eth_flutter/models/group_entry.dart';
import 'package:split_eth_flutter/repos/local_group_repo.dart';
import 'package:split_eth_flutter/repos/remote_group_repo.dart';

import '../../value_objects/group_id.dart';

class GroupController extends ChangeNotifier {
  GroupController._(GroupId groupId) : _groupId = groupId;

  final GroupId _groupId;
  final RemoteGroupRepo _remoteGroupRepo = GetIt.I.get<RemoteGroupRepo>();

  Group get group => GetIt.I<LocalGroupRepo>().getGroupById(_groupId);

  Future<void> refreshGroup() async {
    Group group = await _remoteGroupRepo.getRemoteGroup(_groupId);
    GetIt.I.get<LocalGroupRepo>().updateGroup(group);
    notifyListeners();
  }

  void addEntry(GroupEntry entry) {
    final newGroup = group.copyWith(entries: [...group.entries, entry]);
    GetIt.I<LocalGroupRepo>().updateGroup(newGroup);
    notifyListeners();
  }

  void removeEntry(GroupEntry entry) {
    final newEntries = group.entries.where((e) => e != entry).toList();
    final newGroup = group.copyWith(entries: newEntries);
    GetIt.I<LocalGroupRepo>().updateGroup(newGroup);
    notifyListeners();
  }

  Widget withView(Widget child) {
    return ChangeNotifierProvider.value(
      value: this,
      child: child,
    );
  }

  static final Map<GroupId, GroupController> _instances = {};
  static GroupController of(GroupId groupId) {
    return _instances.putIfAbsent(groupId, () => GroupController._(groupId));
  }
}
