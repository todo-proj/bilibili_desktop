import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';


class DoubleTapMaximizeArea extends StatefulWidget {
  final Widget child;

  const DoubleTapMaximizeArea({Key? key, required this.child}) : super(key: key);

  @override
  _DoubleTapMaximizeAreaState createState() => _DoubleTapMaximizeAreaState();
}

class _DoubleTapMaximizeAreaState extends State<DoubleTapMaximizeArea> {
  bool _shouldInterceptEvents = false;
  int _tapCount = 0;
  Timer? _timer;

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerDown: _handlePointerDown,
      onPointerMove: _handlePointerMove, // 添加拖拽事件
      behavior: HitTestBehavior.translucent,
      child: _shouldInterceptEvents
          ? AbsorbPointer(child: widget.child)
          : widget.child,
    );
  }

  void _handlePointerDown(PointerDownEvent event) {
    _tapCount++;

    if (_tapCount == 1) {
      _timer = Timer(const Duration(milliseconds: 300), () {
        _tapCount = 0;
        setState(() {
          _shouldInterceptEvents = false;
        });
      });
    } else if (_tapCount == 2) {
      _timer?.cancel();
      _tapCount = 0;
      setState(() {
        _shouldInterceptEvents = true;
      });
      _handleDoubleTap();
    }
  }

  void _handlePointerMove(PointerMoveEvent event) {
    if (_shouldInterceptEvents) return; // 如果正在处理双击，跳过拖动

    // 调用 window_manager 实现窗口拖动
    windowManager.startDragging();
  }

  void _handleDoubleTap() async {
    if (Platform.isMacOS) {
      final isFullScreen = await windowManager.isFullScreen();
      windowManager.setFullScreen(!isFullScreen);
    } else {
      if (await windowManager.isMaximized()) {
        windowManager.unmaximize();
      } else {
        windowManager.maximize();
      }
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}