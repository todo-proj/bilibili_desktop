import 'package:flutter/material.dart';

class DialogPage<T> extends Page<T> {
  final Color? barrierColor;
  final bool barrierDismissible;
  final String? barrierLabel;
  final WidgetBuilder builder;
  final bool opaque;

  const DialogPage({
    required this.builder,
    this.barrierColor = Colors.black54,
    this.barrierDismissible = true,
    this.barrierLabel,
    this.opaque = false,
    super.key,
    super.name,
    super.arguments,
    super.restorationId,
  });

  @override
  Route<T> createRoute(BuildContext context) {
    return PageRouteBuilder(
      settings: this,
      opaque: opaque, // 透明背景
      barrierColor: barrierColor,
      barrierLabel: barrierLabel,
      barrierDismissible: barrierDismissible,
      pageBuilder: (context, animation, secondaryAnimation) {
        return FadeTransition(
          opacity: animation,
          child: builder(context),
        );
      },
    );
  }
}
