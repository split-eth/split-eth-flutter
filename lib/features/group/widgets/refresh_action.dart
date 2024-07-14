import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:split_eth_flutter/features/group/controller.dart';

class RefreshAction extends StatelessWidget {
  const RefreshAction({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: context.read<GroupController>().refreshGroup,
      icon: const Icon(Icons.refresh),
    );
  }
}
