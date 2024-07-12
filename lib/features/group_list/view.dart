import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../models/group.dart';

const mockGroupList = [
  Group(id: '458325'),
  Group(id: '723498'),
];

class GroupListView extends StatelessWidget {
  const GroupListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Groups'),
      ),
      body: ListView.builder(
        itemCount: mockGroupList.length,
        itemBuilder: (context, index) {
          final Group group = mockGroupList[index];
          return ListTile(
            title: Text('Group ${group.id}'),
            onTap: () => context.go('/groups/${group.id}'),
          );
        },
      ),
    );
  }
}
