import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:split_eth_flutter/repos/local_group_repo.dart';
import 'package:split_eth_flutter/value_objects/group_id.dart';
import 'package:split_eth_flutter/vendor/web3/config.dart';
import 'package:split_eth_flutter/vendor/web3/contracts/group_contract.dart';
import 'package:split_eth_flutter/vendor/web3/contracts/group_factory_contract.dart';
import 'package:web3dart/web3dart.dart';

import '../../models/group.dart';

class GroupListController extends ChangeNotifier {
  GroupListController._();

  final Config _config = GetIt.I.get<Config>();
  final GroupFactoryContract _groupFactoryContract = GetIt.I.get<GroupFactoryContract>();

  List<Group> get groups => GetIt.I.get<LocalGroupRepo>().getGroups();

  Future<Group> getRemoteGroup(GroupId groupId) async {
    EthereumAddress groupAddress = await _groupFactoryContract.getAddress(
      EthereumAddress.fromHex(_config.token.address),
      groupId.toString(),
    );

    final GroupContract groupContract = await GroupContract.init(groupAddress);

    late final String name;
    try {
      name = await groupContract.getName();
    } on RangeError {
      throw Exception('Group does not exist');
    }
    
    return Group(
      // TODO add name and address
      id: groupId,
      entries: const [], // TODO
    );
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
