import 'dart:io';

import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';

class AdvancedDraggableArea extends StatefulWidget {
  final Widget child;

  const AdvancedDraggableArea({Key? key, required this.child}) : super(key: key);

  @override
  _AdvancedDraggableAreaState createState() => _AdvancedDraggableAreaState();
}

class _AdvancedDraggableAreaState extends State<AdvancedDraggableArea> {
  bool _isDragging = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.move,
      child: Listener(
        onPointerDown: (event) {
          _isDragging = true;
          windowManager.startDragging();
        },
        onPointerUp: (event) {
          _isDragging = false;
        },
        child: widget.child,
      ),
    );
  }
}

class DoubleTapMaximizeArea extends StatelessWidget {
  final Widget child;

  const DoubleTapMaximizeArea({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onDoubleTap: _handleDoubleTap,
      onPanStart: (details) {
        windowManager.startDragging();
      },
      child: child,
    );
  }

  void _handleDoubleTap() async{
    if (Platform.isMacOS) {
      final isFullScreen = await windowManager.isFullScreen();
      windowManager.setFullScreen(!isFullScreen);
    }else {
      if (await windowManager.isMaximized()) {
        windowManager.unmaximize();
      } else {
        windowManager.maximize();
      }
    }
  }
}