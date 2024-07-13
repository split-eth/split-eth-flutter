import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:split_eth_flutter/repos/local_group_repo.dart';

import '../../models/group.dart';
import 'view.dart';

class AddGroupController extends ChangeNotifier {
  AddGroupController._();

  void addGroup(Group group) {
    GetIt.I.get<LocalGroupRepo>().addGroup(group);
    notifyListeners();
  }

  static Widget createView() {
    return ChangeNotifierProvider(
      create: (_) => AddGroupController._(),
      child: const AddGroupView(),
    );
  }
}
