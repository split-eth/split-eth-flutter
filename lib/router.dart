import 'package:go_router/go_router.dart';
import 'package:split_eth_flutter/features/group/view.dart';
import 'package:split_eth_flutter/features/group_list/view.dart';

final router = GoRouter(
  initialLocation: '/groups',
  routes: [
    GoRoute(
      path: '/groups',
      builder: (context, state) => const GroupListView(),
    ),
    GoRoute(
      path: '/groups/:id',
      builder: (context, state) => GroupView(groupId: state.pathParameters['id']!),
    ),
  ],
);
