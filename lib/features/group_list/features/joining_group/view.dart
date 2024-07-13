import 'package:flutter/material.dart';
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
  String? error;
  bool loading = true;

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      contentPadding: const EdgeInsets.all(24),
      children: [_dialog()],
    );
  }

  Widget _dialog() {
    if (error != null) {
      return Center(
        child: Text(error!, style: const TextStyle(color: Colors.red)),
      );
    }

    if (loading) {
      return const Center(child: CircularProgressIndicator());
    }

    return const Text('success!'); // TODO
  }
}
