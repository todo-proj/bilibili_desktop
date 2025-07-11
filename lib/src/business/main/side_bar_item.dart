import 'package:flutter/material.dart';

class SideBarItem {
  final String? title;
  final IconData? icon;
  final bool maintainState;
  final String tag;
  final dynamic object;

  SideBarItem({
    this.icon,
    this.title,
    this.maintainState = true,
    this.object,
    required this.tag,
  });

  copyWith({
    String? title,
    IconData? icon,
    bool? maintainState,
    Widget? child,
    String? tag,
    dynamic object,
  }) {
    return SideBarItem(
      title: title ?? this.title,
      icon: icon ?? this.icon,
      maintainState: maintainState ?? this.maintainState,
      tag: tag ?? this.tag,
      object: object ?? this.object,
    );
  }
}