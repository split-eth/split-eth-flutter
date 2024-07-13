import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:split_eth_flutter/repos/local_group_repo.dart';

import '../../models/group.dart';
import 'view.dart';

class GroupListController extends ChangeNotifier {
  GroupListController._();

  List<Group> get groups => GetIt.I.get<LocalGroupRepo>().getGroups();

  static Widget createView() {
    return ChangeNotifierProvider(
      create: (_) => GroupListController._(),
      child: const GroupListView(),
    );
  }
}
