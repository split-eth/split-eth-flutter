import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:split_eth_flutter/models/group.dart';

const namespace = 'groups';

class LocalGroupRepo {
  LocalGroupRepo(SharedPreferences prefs) : _prefs = prefs;

  final SharedPreferences _prefs;

  final _jsonEncoder = JsonEncoder.withIndent(' ' * 6);

  void addGroup(Group group) {
    _prefs.setString('$namespace/${group.id}', _jsonEncoder.convert(group.toJson()));
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
    final String value = _prefs.getString('$namespace/$key') ?? '{}';
    return Group.fromJson(jsonDecode(value));
  }
}
