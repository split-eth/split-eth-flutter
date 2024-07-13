import 'package:go_router/go_router.dart';
import 'package:split_eth_flutter/features/add_group/view.dart';
import 'package:split_eth_flutter/features/group/view.dart';
import 'package:split_eth_flutter/features/group_list/controller.dart';

import 'utils/dialog_page.dart';

GoRouter createRouterConfig() {
  return GoRouter(
    initialLocation: '/groups',
    routes: [
      GoRoute(
        path: '/groups',
        builder: (context, state) => GroupListController.createView(),
        routes: [
          GoRoute(
            path: 'new',
            pageBuilder: (_, __) => DialogPage(builder: (_) => const AddGroupView()),
          ),
          GoRoute(
            path: ':id',
            builder: (_, state) => GroupView(groupId: state.pathParameters['id']!),
          ),
        ],
      ),
    ],
  );
}
