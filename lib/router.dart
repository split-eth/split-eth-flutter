import 'package:go_router/go_router.dart';
import 'package:split_eth_flutter/features/group/controller.dart';
import 'package:split_eth_flutter/features/group_list/controller.dart';
import 'package:split_eth_flutter/features/group_list/view.dart';
import 'package:split_eth_flutter/value_objects/group_id.dart';

import 'features/group_list/features/add_group/view.dart';
import 'utils/dialog_page.dart';

GoRouter createRouterConfig() {
  return GoRouter(
    initialLocation: '/groups',
    routes: [
      GoRoute(
        path: '/groups',
        builder: (context, state) => GroupListController.withView(const GroupListView()),
        routes: [
          GoRoute(
            path: 'new',
            pageBuilder: (_, __) => DialogPage(builder: (_) => GroupListController.withView(const AddGroupView())),
          ),
          GoRoute(
            path: ':id',
            builder: (_, state) => GroupController.of(GroupId(state.pathParameters['id']!)).createView(),
          ),
        ],
      ),
    ],
  );
}
