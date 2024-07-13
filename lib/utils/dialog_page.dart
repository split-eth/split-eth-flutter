import 'package:flutter/material.dart';

class DialogPage<T> extends Page<T> {
  const DialogPage({
    super.key,
    required this.builder,
  });

  final WidgetBuilder builder;

  @override
  Route<T> createRoute(BuildContext context) {
    return DialogRoute<T>(
      context: context,
      settings: this,
      builder: builder,
    );
  }
}
