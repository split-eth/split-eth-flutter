import 'package:go_router/go_router.dart';
import 'package:split_eth_flutter/features/group/controller.dart';
import 'package:split_eth_flutter/features/group/features/add_group_entry/view.dart';
import 'package:split_eth_flutter/features/group/view.dart';
import 'package:split_eth_flutter/features/group_list/controller.dart';
import 'package:split_eth_flutter/features/group_list/features/auth/view.dart';
import 'package:split_eth_flutter/features/group_list/features/joining_group/view.dart';
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
            path: 'auth',
            pageBuilder: (_, __) => DialogPage(
              // barrierDismissible: false, // TODO enable
              builder: (_) => GroupListController.withView(const AuthView()),
            ),
          ),
          GoRoute(
            path: 'new',
            pageBuilder: (_, __) => DialogPage(builder: (_) => GroupListController.withView(const AddGroupView())),
          ),
          GoRoute(
            path: 'joining',
            pageBuilder: (_, state) {
              final GroupId groupId = GroupId(state.uri.queryParameters['id']!);
              return DialogPage(
                barrierDismissible: false,
                builder: (_) => GroupListController.withView(JoiningGroupView(groupId: groupId)),
              );
            },
          ),
          GoRoute(
              path: ':id',
              builder: (_, state) {
                final controller = GroupController.of(GroupId(state.pathParameters['id']!));
                return controller.withView(const GroupView());
              },
              routes: [
                GoRoute(
                  path: 'add_entry',
                  pageBuilder: (_, state) {
                    final controller = GroupController.of(GroupId(state.pathParameters['id']!));
                    return DialogPage(builder: (_) => controller.withView(const AddGroupEntryView()));
                  },
                ),
              ]),
        ],
      ),
    ],
  );
}
