import 'package:flutter/material.dart';

class DialogPage<T> extends Page<T> {
  const DialogPage({
    super.key,
    required this.builder,
    this.barrierDismissible = true,
  });

  final WidgetBuilder builder;
  final bool barrierDismissible;

  @override
  Route<T> createRoute(BuildContext context) {
    return DialogRoute<T>(
      barrierDismissible: barrierDismissible,
      context: context,
      settings: this,
      builder: builder,
    );
  }
}
