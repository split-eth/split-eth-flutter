import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:split_eth_flutter/features/group_list/widgets/group_list_item.dart';

import '../../models/group.dart';
import 'controller.dart';

class GroupListView extends StatefulWidget {
  const GroupListView({super.key});

  @override
  State createState() => _GroupListViewState();
}

class _GroupListViewState extends State<GroupListView> {
  @override
  void initState() {
    super.initState();

    // post frame callback
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // initial requests go here

      onLoad();
    });
  }

  void onLoad() async {
    await context.read<GroupListController>().checkAuth();

    if (!mounted) {
      return;
    }

    // I don't have time to do this properly
    final isLoggedIn = context.read<GroupListController>().isLoggedIn;
    if (!isLoggedIn) {
      context.go('/groups/auth');
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<Group> groups = context.select((GroupListController c) => c.groups);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Groups'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.go('/groups/new'),
        child: const Icon(Icons.add),
      ),
      body: ListView.builder(
        itemCount: groups.length,
        itemBuilder: (context, index) => GroupListItem(group: groups[index]),
      ),
    );
  }
}
