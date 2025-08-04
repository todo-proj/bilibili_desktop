import 'package:flutter/material.dart';

class SecondaryClickMenuWrapper<T> extends StatelessWidget {
  final Widget child;
  final List<PopupMenuEntry<T>> items;
  final ValueChanged<T>? onSelected;
  final VoidCallback? onCanceled;
  final ShapeBorder? shape;
  final EdgeInsetsGeometry? menuPadding;
  final Color? color;

  const SecondaryClickMenuWrapper({
    super.key,
    required this.child,
    required this.items,
    this.onSelected,
    this.onCanceled,
    this.shape,
    this.menuPadding,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onSecondaryTapDown: (details) {
        _showContextMenu(context, details.globalPosition);
      },
      child: child,
    );
  }

  void _showContextMenu(BuildContext context, Offset position) async {
    final RenderBox overlay =
        Overlay.of(context).context.findRenderObject() as RenderBox;
    final Size screenSize = overlay.size;

    // 简单估算菜单的宽高（你可以更精准地估算）
    const double menuWidth = 150;
    final double menuHeight = items.length * 48.0;

    double left = position.dx;
    double top = position.dy;

    // 如果右边空间不够，就向左弹
    if (position.dx + menuWidth > screenSize.width) {
      left = position.dx - menuWidth;
    }

    // 如果底部空间不够，就向上弹
    if (position.dy + menuHeight > screenSize.height) {
      top = position.dy - menuHeight;
    }

    final selected = await showMenu<T>(
      context: context,
      position: RelativeRect.fromLTRB(left, top, left, top),
      menuPadding: menuPadding,
      color: color,
      shape: shape,
      items: items,
    );

    if (selected != null) {
      onSelected?.call(selected);
    } else {
      onCanceled?.call();
    }
  }
}
