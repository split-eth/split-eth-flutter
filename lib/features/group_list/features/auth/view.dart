import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:split_eth_flutter/atoms/seth_text_field.dart';
import 'package:split_eth_flutter/features/group_list/controller.dart';
import 'package:split_eth_flutter/atoms/labeled_divider.dart';
import 'package:split_eth_flutter/value_objects/group_id.dart';

import '../../../../models/group.dart';

class AuthView extends StatelessWidget {
  const AuthView({super.key});

  @override
  Widget build(BuildContext context) {
    final phoneNumber = context.select((GroupListController c) => c.phoneNumber);

    final authResponse = context.select((GroupListController c) => c.authResponse);

    print('authResponse: $authResponse');

    return SimpleDialog(
      contentPadding: const EdgeInsets.all(24),
      children: [
        if (authResponse == null)
          SethTextField(
            key: const ValueKey('phone_number'),
            label: 'Phone number (+32478123123)',
            // NOTE: needed to show "done" button on iOS
            keyboardType: const TextInputType.numberWithOptions(signed: true),
            onChanged: (String value) => handlePhoneNumber(context, value),
          ),
        if (authResponse != null)
          SethTextField(
            key: const ValueKey('code'),
            label: 'Enter code',
            // NOTE: needed to show "done" button on iOS
            keyboardType: const TextInputType.numberWithOptions(signed: true),
            onChanged: (String value) => handleCodeChange(context, value),
          ),
        if (phoneNumber.isNotEmpty)
          const SizedBox(
            height: 20,
          ),
        if (phoneNumber.isNotEmpty && authResponse == null)
          ElevatedButton.icon(
            icon: const Icon(Icons.sms),
            label: const Text('Log in'),
            onPressed: () => handleLogIn(context),
          ),
        if (authResponse != null)
          ElevatedButton.icon(
            icon: const Icon(Icons.lock),
            label: const Text('Start session'),
            onPressed: () => handleStartSession(context),
          ),
      ],
    );
  }

  void handlePhoneNumber(BuildContext context, String value) {
    context.read<GroupListController>().updatePhoneNumber(value);
  }

  void handleLogIn(BuildContext context) {
    context.read<GroupListController>().logIn();
  }

  void handleCodeChange(BuildContext context, String value) {
    context.read<GroupListController>().updateCode(value);
  }

  void handleStartSession(BuildContext context) {
    context.read<GroupListController>().startSession();
  }
}
