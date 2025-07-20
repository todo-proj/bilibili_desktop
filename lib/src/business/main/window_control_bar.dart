import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';

import '../common/app_icons.dart';

class WindowControlsBar extends StatefulWidget {
  const WindowControlsBar({super.key});

  @override
  State<WindowControlsBar> createState() => _WindowControlsBarState();
}

class _WindowControlsBarState extends State<WindowControlsBar> {

  bool _isMaximized = false;

  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _buildSystemTitleBarItem(
            onPressed: () {
              windowManager.minimize();
            },
            icon: const Icon(AppIcons.minimize),
          ),
          _buildSystemTitleBarItem(
            onPressed: () async {
              _isMaximized = await windowManager.isMaximized();
              if (_isMaximized) {
                windowManager.unmaximize();
              } else {
                windowManager.maximize();
              }
              setState(() {
                _isMaximized = !_isMaximized;
              });
            },
            icon: _isMaximized ? const Icon(AppIcons.unMaximize) : const Icon(AppIcons.maximize),
          ),
          _buildSystemTitleBarItem(
            onPressed: () {
              windowManager.close();
            },
            icon: const Icon(AppIcons.shutDown),
          )
        ]
    );
  }

  Widget _buildSystemTitleBarItem({required Icon icon, required VoidCallback onPressed}) {
    return IconButton(
      onPressed: onPressed,
      icon: icon,
    );
  }
}
