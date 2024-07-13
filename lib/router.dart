import 'package:go_router/go_router.dart';
import 'package:split_eth_flutter/features/group/view.dart';
import 'package:split_eth_flutter/features/group_list/controller.dart';

GoRouter createRouterConfig() {
  return GoRouter(
    initialLocation: '/groups',
    routes: [
      GoRoute(
        path: '/groups',
        builder: (context, state) => GroupListController.createView(),
        routes: [
          GoRoute(
            path: ':id',
            builder: (context, state) => GroupView(groupId: state.pathParameters['id']!),
          ),
        ],
      ),
    ],
  );
}
