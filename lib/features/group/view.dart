import 'package:flutter/material.dart';

class GroupView extends StatelessWidget {
  const GroupView({
    super.key,
    required this.groupId,
  });

  final String groupId;

  @override
  Widget build(BuildContext context) {
    return const Text('group view');
  }
}
