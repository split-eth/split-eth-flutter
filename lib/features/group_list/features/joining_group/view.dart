import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:split_eth_flutter/features/group_list/controller.dart';
import 'package:split_eth_flutter/value_objects/group_id.dart';

class JoiningGroupView extends StatefulWidget {
  const JoiningGroupView({
    super.key,
    required this.groupId,
  });

  final GroupId groupId;

  @override
  State<JoiningGroupView> createState() => _JoiningGroupViewState();
}

class _JoiningGroupViewState extends State<JoiningGroupView> {
  late final Future<void> _future;

  @override
  void initState() {
    super.initState();
    _future = context.read<GroupListController>().joinGroup(widget.groupId);
  }

  static const double _minHeight = 48;

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      contentPadding: const EdgeInsets.all(24),
      children: [
        ConstrainedBox(
          constraints: const BoxConstraints(minHeight: _minHeight),
          child: FutureBuilder(
            future: _future,
            builder: (context, snapshot) {
              if (snapshot.connectionState != ConnectionState.done) {
                return const Center(child: CircularProgressIndicator());
              }

              if (snapshot.hasError) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      snapshot.error.toString(),
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Colors.red),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        context.pop();
                        context.go('/groups/new');
                      },
                      child: const Text('Back'),
                    ),
                  ],
                );
              }

              WidgetsBinding.instance.addPostFrameCallback((_) {
                context.go('/groups/${widget.groupId}');
              });

              return const Center(
                child: Icon(
                  Icons.check_circle,
                  color: Colors.green,
                  size: _minHeight,
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
