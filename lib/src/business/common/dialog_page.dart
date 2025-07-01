import 'package:flutter/material.dart';

class DialogPage<T> extends Page<T> {
  final Offset? anchorPoint;
  final Color? barrierColor;
  final bool barrierDismissible;
  final String? barrierLabel;
  final bool useSafeArea;
  final CapturedThemes? themes;
  final WidgetBuilder builder;

  const DialogPage({
    required this.builder,
    this.anchorPoint,
    this.barrierColor = Colors.black87,
    this.barrierDismissible = true,
    this.barrierLabel,
    this.useSafeArea = true,
    this.themes,
    super.key,
    super.name,
    super.arguments,
    super.restorationId,
  });

  // @override
  // Route<T> createRoute(BuildContext context) => DialogRoute<T>(
  //   context: context,
  //   settings: this,
  //   builder: (context)=>Dialog(
  //       child: builder(context),
  //   ),
  //   anchorPoint: anchorPoint,
  //   barrierColor: barrierColor,
  //   barrierDismissible: barrierDismissible,
  //   barrierLabel: barrierLabel,
  //   useSafeArea: useSafeArea,
  //   themes: themes,
  // );

  @override
  Route<T> createRoute(BuildContext context) {
    return PageRouteBuilder(
      settings: this,
      opaque: false, // 透明背景
      barrierColor: Colors.black54,
      barrierDismissible: true,
      pageBuilder: (context, animation, secondaryAnimation) {
        return FadeTransition(
          opacity: animation,
          child: builder(context),
        );
      },
    );
  }
}
