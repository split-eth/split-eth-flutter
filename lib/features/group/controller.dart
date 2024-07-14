import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:split_eth_flutter/models/group.dart';
import 'package:split_eth_flutter/models/group_entry.dart';
import 'package:split_eth_flutter/repos/local_group_repo.dart';
import 'package:split_eth_flutter/repos/remote_group_repo.dart';
import 'package:split_eth_flutter/repos/session_repo.dart';
import 'package:split_eth_flutter/value_objects/group_entry_id.dart';
import 'package:split_eth_flutter/vendor/web3/contracts/group_contract.dart';
import 'package:split_eth_flutter/vendor/web3/contracts/session_account_manager.dart';
import 'package:split_eth_flutter/vendor/web3/service.dart';
import 'package:web3dart/crypto.dart';
import 'package:web3dart/web3dart.dart';

import '../../value_objects/group_id.dart';

class GroupController extends ChangeNotifier {
  GroupController._(GroupId groupId) : _groupId = groupId;

  final GroupId _groupId;
  final RemoteGroupRepo _remoteGroupRepo = GetIt.I.get<RemoteGroupRepo>();

  Group get group => GetIt.I<LocalGroupRepo>().getGroupById(_groupId);

  EthPrivateKey? credentials;
  EthereumAddress? account;

  Future<void> loadAccount() async {
    try {
      String? key = GetIt.I.get<LocalSessionRepo>().getSessionKey();
      if (key == null) {
        return;
      }

      String? phoneNumber = GetIt.I.get<LocalSessionRepo>().getPhoneNumber() ?? '';
      if (phoneNumber.isEmpty) {
        return;
      }

      credentials = EthPrivateKey(hexToBytes(key));

      account = await GetIt.I.get<SessionAccountManagerContract>().getAddress(phoneNumber.trim());
    } catch (e, s) {
      print(e);
      print(s);
    }
  }

  Future<void> refreshGroup() async {
    Group group = await _remoteGroupRepo.getRemoteGroup(_groupId);
    GetIt.I.get<LocalGroupRepo>().updateGroup(group);
    notifyListeners();
  }

  Future<void> addEntry(BigInt amount, String note) async {
    if (account == null) {
      return;
    }

    final GroupEntry entry = GroupEntry(
      id: GroupEntryId.random(),
      address: account!, // TODO
      name: 'TODO', // TODO
      amount: amount,
      note: note,
    );

    final newGroup = group.copyWith(entries: [...group.entries, entry]);
    GetIt.I<LocalGroupRepo>().updateGroup(newGroup);
    notifyListeners();

    final success = await uploadEntry(entry);
    if (!success) {
      removeEntry(entry);
    }
  }

  void removeEntry(GroupEntry entry) {
    final newEntries = group.entries.where((e) => e != entry).toList();
    final newGroup = group.copyWith(entries: newEntries);
    GetIt.I<LocalGroupRepo>().updateGroup(newGroup);
    notifyListeners();
  }

  Future<bool> uploadEntry(GroupEntry entry) async {
    try {
      String? key = GetIt.I.get<LocalSessionRepo>().getSessionKey();
      if (key == null) {
        return false;
      }

      String? phoneNumber = GetIt.I.get<LocalSessionRepo>().getPhoneNumber() ?? '';
      if (phoneNumber.isEmpty) {
        return false;
      }

      final credentials = EthPrivateKey(hexToBytes(key));

      final dest = await GetIt.I.get<SessionAccountManagerContract>().getAddress(phoneNumber.trim());

      print('credentials.address: ${credentials.address.hexEip55}');
      print('dest: $dest');
      print('group.address: ${group.address.hexEip55}');

      final contract = await GroupContract.init(group.address);

      final calldata = contract.addEntryCallData(dest, entry.amount, entry.note);

      final (_, userop) = await GetIt.I
          .get<Web3Service>()
          .prepareUserop(credentials, dest, phoneNumber.trim(), [dest.hexEip55], [calldata]);

      print('submitting...');
      final tx = await GetIt.I.get<Web3Service>().submitUserop(userop);
      print(tx);
      if (tx == null) {
        throw Exception('Transaction is null');
      }

      final success = await GetIt.I.get<Web3Service>().waitForTxSuccess(tx);
      if (!success) {
        throw Exception('Transaction failed');
      }

      return true;
    } catch (e, s) {
      print(e);
      print(s);
    }

    return false;
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
