import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:split_eth_flutter/repos/local_group_repo.dart';

import '../../models/group.dart';

class GroupListController extends ChangeNotifier {
  GroupListController._();

  List<Group> get groups => GetIt.I.get<LocalGroupRepo>().getGroups();

  void addGroup(Group group) {
    GetIt.I.get<LocalGroupRepo>().addGroup(group);
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
