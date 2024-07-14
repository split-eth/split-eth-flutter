import 'dart:convert';

import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:split_eth_flutter/models/group.dart';
import 'package:split_eth_flutter/value_objects/group_id.dart';

const namespace = 'groups';

class LocalGroupRepo {
  final _jsonEncoder = JsonEncoder.withIndent(' ' * 6);
  final SharedPreferences _prefs = GetIt.I.get<SharedPreferences>();

  void addGroup(Group group) {
    if (_prefs.containsKey('$namespace/${group.id}')) {
      throw Exception('Group already exists');
    }
    updateGroup(group);
  }

  void updateGroup(Group group) {
    _prefs.setString('$namespace/${group.id}', _jsonEncoder.convert(group.toJson()));
  }

  void removeGroup(Group group) {
    _prefs.remove('$namespace/${group.id}');
  }

  void removeAllGroups() {
    _prefs
        .getKeys()
        .where((key) => key.startsWith('$namespace/'))
        .forEach(_prefs.remove);
  }

  List<Group> getGroups() {
    return _prefs
        .getKeys()
        .where((key) => key.startsWith('$namespace/'))
        .map((key) => _getGroupByKey(key))
        .toList();
  }

  bool hasGroup(GroupId groupId) {
    return _prefs.containsKey('$namespace/$groupId');
  }

  Group getGroupById(GroupId groupId) {
    return _getGroupByKey('$namespace/$groupId');
  }

  Group _getGroupByKey(String key) {
    final String? value = _prefs.getString(key);
    if (value == null) {
      throw Exception('Group not found');
    }
    return Group.fromJson(jsonDecode(value));
  }
}
