import 'package:flutter/material.dart';

class AddGroupView extends StatelessWidget {
  const AddGroupView({super.key});

  @override
  Widget build(BuildContext context) {
    return const SimpleDialog(
      contentPadding: EdgeInsets.all(24),
      children: [
        Text('dialog'),
      ],
    );
  }
}
