import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:split_eth_flutter/repos/local_group_repo.dart';
import 'package:split_eth_flutter/value_objects/group_id.dart';

import '../../models/group.dart';

class GroupListController extends ChangeNotifier {
  GroupListController._();

  List<Group> get groups => GetIt.I.get<LocalGroupRepo>().getGroups();

  Future<Group> getRemoteGroup(GroupId groupId) async {
    // TODO
    await Future.delayed(const Duration(seconds: 1));
    throw UnimplementedError();
  }

  void addLocalGroup(Group group) {
    GetIt.I.get<LocalGroupRepo>().addGroup(group);
    notifyListeners();
  }

  void removeLocalGroup(Group group) {
    GetIt.I.get<LocalGroupRepo>().removeGroup(group);
    notifyListeners();
  }

  static final GroupListController _instance = GroupListController._();
  static Widget withView(Widget child) {
    return ChangeNotifierProvider.value(
      value: _instance,
      child: child,
    );
  }
}
