import 'package:flutter/material.dart';

class LabeledDivider extends StatelessWidget {
  LabeledDivider({
    super.key,
    required this.label,
  });

  final String label;

  final double _outerIndent = 15;
  final double _innerIndent = 15;
  final Color _dividerColor = Colors.grey;
  final Color _textColor = Colors.grey.shade600;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Divider(
            indent: _outerIndent,
            endIndent: _innerIndent,
            color: _dividerColor,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 3),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 20,
              color: _textColor,
            ),
          ),
        ),
        Expanded(
          child: Divider(
            indent: _innerIndent,
            endIndent: _outerIndent,
            color: _dividerColor,
          ),
        ),
      ],
    );
  }
}
