import 'dart:convert';

import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:split_eth_flutter/models/group.dart';

const namespace = 'groups';

class LocalGroupRepo {
  final _jsonEncoder = JsonEncoder.withIndent(' ' * 6);
  final SharedPreferences _prefs = GetIt.I.get<SharedPreferences>();

  void addGroup(Group group) {
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

  Group getGroupById(String id) {
    return _getGroupByKey('$namespace/$id');
  }

  Group _getGroupByKey(String key) {
    final String? value = _prefs.getString(key);
    if (value == null) {
      throw Exception('Group not found');
    }
    return Group.fromJson(jsonDecode(value));
  }
}
