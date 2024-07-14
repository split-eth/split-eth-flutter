import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:split_eth_flutter/repos/local_group_repo.dart';
import 'package:split_eth_flutter/repos/remote_group_repo.dart';
import 'package:split_eth_flutter/repos/session_repo.dart';
import 'package:split_eth_flutter/value_objects/group_id.dart';
import 'package:split_eth_flutter/vendor/web3/contracts/session_account.dart';
import 'package:split_eth_flutter/vendor/web3/contracts/session_account_manager.dart';
import 'package:split_eth_flutter/vendor/web3/service.dart';
import 'package:split_eth_flutter/vendor/web3/services/auth/auth.dart';
import 'package:web3dart/crypto.dart';
import 'package:web3dart/web3dart.dart';

import '../../models/group.dart';

class GroupListController extends ChangeNotifier {
  GroupListController._();

  final RemoteGroupRepo _remoteGroupRepo = GetIt.I.get<RemoteGroupRepo>();

  SessionAccountContract? sessionAccountContract;

  String? key;
  bool isLoggedIn = false;

  String code = '';
  String phoneNumber = '';

  AuthResponse? authResponse;

  Future<void> checkAuth() async {
    try {
      key = GetIt.I.get<LocalSessionRepo>().getSessionKey();
      if (key == null) {
        return;
      }

      phoneNumber = GetIt.I.get<LocalSessionRepo>().getPhoneNumber() ?? '';
      if (phoneNumber.isEmpty) {
        return;
      }

      final address = await GetIt.I.get<SessionAccountManagerContract>().getAddress(phoneNumber);

      final sContract = await SessionAccountContract.init(address.hexEip55, GetIt.I.get<Web3Service>().ethClient);

      final owner = await sContract.getOwner();
      if (owner.hexEip55 != address.hexEip55) {
        isLoggedIn = false;
        return;
      }

      isLoggedIn = true;
    } catch (e, s) {
      print(e);
      print(s);
      isLoggedIn = false;
    }
    notifyListeners();
  }

  void updatePhoneNumber(String value) {
    phoneNumber = value;
    notifyListeners();
  }

  void updateCode(String value) {
    code = value;
    notifyListeners();
  }

  Future<void> logIn() async {
    try {
      if (key == null) {
        final random = Random.secure();
        final credentials = EthPrivateKey.createRandom(random);

        GetIt.I.get<LocalSessionRepo>().setSessionKey(bytesToHex(credentials.privateKey, include0x: true));

        key = bytesToHex(credentials.privateKey, include0x: true);
      }

      final credentials = EthPrivateKey(hexToBytes(key!));

      final hashRequest = HashRequest(types: [
        'string',
        'address'
      ], values: [
        phoneNumber.trim(),
        credentials.address.hexEip55,
      ]);

      final hash = await GetIt.I.get<AuthService>().hash(hashRequest);

      final signature = credentials.signPersonalMessageToUint8List(hexToBytes(hash.hash));
      // final signature = await signHash(credentials, hash);

      print('phoneNumber: ${phoneNumber.trim()}');
      print('address: ${credentials.address.hexEip55}');
      // print('hash: ${bytesToHex(hash, include0x: true)}');
      print('hash: $hash');
      print('signature: ${bytesToHex(signature, include0x: true)}');
      // print('signature: $signature');

      final request = AuthRequest(
        secondFactor: phoneNumber.trim(),
        sessionAddress: credentials.address.hexEip55,
        signature: bytesToHex(signature, include0x: true),
      );

      authResponse = await GetIt.I.get<AuthService>().request(request);
      notifyListeners();
    } catch (e, s) {
      print(e);
      print(s);
    }
  }

  Future<void> startSession() async {
    try {
      final String salt = code;
      if (code.isEmpty) {
        throw Exception('Code is empty');
      }

      if (key == null) {
        throw Exception('Key is null');
      }

      if (authResponse == null) {
        throw Exception('AuthResponse is null');
      }

      final credentials = EthPrivateKey(hexToBytes(key!));

      final hashRequest = HashRequest(types: [
        "address",
        "string",
        "address",
        "string"
      ], values: [
        authResponse!.provider,
        phoneNumber.trim(),
        credentials.address.hexEip55,
        salt,
      ]);

      final hash = await GetIt.I.get<AuthService>().hash(hashRequest);

      final signature = credentials.signPersonalMessageToUint8List(hexToBytes(hash.hash));

      final calldata = GetIt.I
          .get<SessionAccountManagerContract>()
          .startSessionCallData(salt, credentials.address, hexToBytes(authResponse!.signature), signature);

      final dest = await GetIt.I.get<SessionAccountManagerContract>().getAddress(phoneNumber.trim());

      final (_, userop) = await GetIt.I
          .get<Web3Service>()
          .prepareUserop(credentials, dest, phoneNumber.trim(), [dest.hexEip55], [calldata]);

      final tx = await GetIt.I.get<Web3Service>().submitUserop(userop);
      if (tx == null) {
        throw Exception('Transaction is null');
      }

      final success = await GetIt.I.get<Web3Service>().waitForTxSuccess(tx);
      if (!success) {
        throw Exception('Transaction failed');
      }

      print('success');
    } catch (e, s) {
      print(e);
      print(s);
    }
  }

  List<Group> get groups => GetIt.I.get<LocalGroupRepo>().getGroups();

  Future<void> joinGroup(GroupId groupId) async {
    if (GetIt.I.get<LocalGroupRepo>().hasGroup(groupId)) {
      throw Exception('You are already in this group');
    }
    Group group = await _remoteGroupRepo.getRemoteGroup(groupId);
    addLocalGroup(group);
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
